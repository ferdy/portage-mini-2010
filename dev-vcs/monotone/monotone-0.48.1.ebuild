# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/monotone/monotone-0.48.1.ebuild,v 1.4 2010/11/09 14:18:39 ranger Exp $

EAPI=2
inherit bash-completion elisp-common eutils toolchain-funcs

DESCRIPTION="Monotone Distributed Version Control System"
HOMEPAGE="http://monotone.ca"
SRC_URI="http://monotone.ca/downloads/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="amd64 ~ia64 ppc x86"
IUSE="doc emacs ipv6 nls"

RDEPEND="sys-libs/zlib
	emacs? ( virtual/emacs )
	>=dev-libs/libpcre-7.6
	>=dev-libs/botan-1.8.0
	>=dev-db/sqlite-3.3.8
	>=dev-lang/lua-5.1
	net-dns/libidn"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.33.1
	nls? ( >=sys-devel/gettext-0.11.5 )
	doc? ( sys-apps/texinfo )"

pkg_setup() {
	enewgroup monotone
	enewuser monotone -1 -1 /var/lib/monotone monotone
}

src_prepare() {
	if [[ $(gcc-major-version) -lt "3"  ||
		( $(gcc-major-version) -eq "3" && $(gcc-minor-version) -le 3 ) ]]; then
		die 'requires >=gcc-3.4'
	fi

	epatch "${FILESDIR}/monotone-0.48.1-sqlite-3.7.3.patch"
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable ipv6)
}

src_compile() {
	emake || die

	if use doc; then
		emake html || die
	fi

	if use emacs; then
		cd contrib
		elisp-compile *.el || die
	fi
}

src_test() {
	if [ ${UID} != 0 ]; then
		emake check || die "emake check failed"
	else
		ewarn "Tests will fail if ran as root, skipping."
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	mv "${D}"/usr/share/doc/${PN} "${D}"/usr/share/doc/${PF} || die

	dobashcompletion contrib/monotone.bash_completion

	if use doc; then
		dohtml -r html/*
		dohtml -r figures
	fi

	if use emacs; then
		elisp-install ${PN} contrib/*.{el,elc} || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}"/50${PN}-gentoo.el \
			|| die
	fi

	dodoc AUTHORS NEWS README* UPGRADE || die
	docinto contrib
	dodoc contrib/*
	newconfd "${FILESDIR}"/monotone.confd monotone || die
	newinitd "${FILESDIR}"/${PN}-0.36.initd monotone || die

	insinto /etc/monotone
	newins "${FILESDIR}"/hooks.lua hooks.lua || die
	newins "${FILESDIR}"/read-permissions read-permissions || die
	newins "${FILESDIR}"/write-permissions write-permissions || die

	keepdir /var/lib/monotone/keys/ /var/{log,run}/monotone
	fowners monotone:monotone /var/lib/monotone{,/keys} /var/{log,run}/monotone
}

pkg_postinst() {
	use emacs && elisp-site-regen
	bash-completion_pkg_postinst

	elog
	elog "For details and instructions to upgrade from previous versions,"
	elog "please read /usr/share/doc/${PF}/UPGRADE.bz2"
	elog
	elog "  1. edit /etc/conf.d/monotone"
	elog "  2. import the first keys to enable access with"
	elog "     env HOME=\${homedir} mtn pubkey me@example.net | /etc/init.d/monotone import"
	elog "     Thereafter, those with write permission can add other keys via"
	elog "     netsync with 'monotone push --key-to-push=IDENT' and then IDENT"
	elog "     can be used in the read-permission and write-permission files."
	elog "  3. adjust permisions in /etc/monotone/read-permissions"
	elog "                      and /etc/monotone/write-permissions"
	elog "  4. start the daemon: /etc/init.d/monotone start"
	elog "  5. make persistent: rc-update add monotone default"
	elog
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
