# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/slim/slim-1.3.2-r3.ebuild,v 1.5 2011/01/10 19:08:34 ranger Exp $

EAPI=2

inherit toolchain-funcs pam eutils

DESCRIPTION="Simple Login Manager"
HOMEPAGE="http://slim.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="branding pam"

RDEPEND="x11-libs/libXmu
	x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXft
	>=media-libs/libpng-1.4
	virtual/jpeg
	x11-apps/sessreg
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xproto"
PDEPEND="branding? ( >=x11-themes/slim-themes-1.2.3a-r3 )"

src_prepare() {
	# respect C[XX]FLAGS, fix crosscompile,
	# fix linking order for --as-needed"
	sed -i -e "s:^CXX=.*:CXX=$(tc-getCXX) ${CXXFLAGS}:" \
		-e "s:^CC=.*:CC=$(tc-getCC) ${CFLAGS}:" \
		-e "s:^MANDIR=.*:MANDIR=/usr/share/man:" \
		-e "s:^\t\(.*\)\ \$(LDFLAGS)\ \(.*\):\t\1\ \2\ \$(LDFLAGS):g" \
		-e "s:-I/usr/include/libpng12:$(pkg-config --cflags-only-I libpng):" \
		-e "s:-lpng12:$(pkg-config --libs-only-l libpng):" \
		-r -e "s:^LDFLAGS=(.*):LDFLAGS=\1 ${LDFLAGS}:" \
		Makefile || die "sed failed in Makefile"
	# Our Gentoo-specific config changes
	epatch "${FILESDIR}/${PN}-1.3.2-r2-config.diff"

	if use branding; then
		sed -i -e 's/  default/  slim-gentoo-simple/' slim.conf || die
	fi

	# Gentoo bug 297655
	epatch "${FILESDIR}/14509-fix-keyboard-in-tty-from-which-${PN}-is-lauched.patch"
	# Upstream bug #15287
	epatch "${FILESDIR}/15287-fix-pam-authentication-with-pam_unix2.patch"
	# Gentoo Bug 261713
	epatch "${FILESDIR}/261713-restart-xserver-if-killed.patch"
	# Gentoo bug 261359, upstream 15326
	epatch "${FILESDIR}/261359-fix-SIGTERM-freeze.patch"
	# Gentoo bug 346037
	epatch "${FILESDIR}/346037-stop_setting_host_for_pam_ck_connector_so.patch"
}

src_compile() {
	if use pam ; then
		emake USE_PAM=1 || die "emake failed."
	else
		emake || die "emake failed."
	fi
}

src_install() {
	if use pam ; then
		emake USE_PAM=1 DESTDIR="${D}" install || die "emake install failed."
		pamd_mimic system-local-login slim auth account session
	else
		emake DESTDIR="${D}" install || die "emake install failed."
	fi

	insinto /usr/share/slim
	newins "${FILESDIR}/Xsession" Xsession || die "newins failed"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/slim.logrotate" slim || die "newins failed"

	dodoc xinitrc.sample ChangeLog README TODO THEMES
}

pkg_postinst() {
	elog
	elog "The configuration file is located at /etc/slim.conf."
	elog
	elog "If you wish ${PN} to start automatically, set DISPLAYMANAGER=\"${PN}\" "
	elog "in /etc/conf.d/xdm and run \"rc-update add xdm default\"."
	elog
	elog "By default, ${PN} now does proper X session selection, including ~/.xsession"
	elog "support, as well as selection between sessions available in"
	elog "/etc/X11/Sessions/ at login by pressing [F1]."
	elog
	elog "The XSESSION environment variable is still supported as a default"
	elog "if no session has been specified by the user."
	elog
	elog "If you want to use .xinitrc in the user's home directory for session"
	elog "management instead, see README and xinitrc.sample in"
	elog "/usr/share/doc/${PF} and change your login_cmd in /etc/slim.conf"
	elog "accordingly."
	elog
	if ! use pam; then
		elog "You have merged ${PN} without USE=pam, this will cause ${PN} to fall back to"
		elog "the console when restarting your window manager. If this is not"
		elog "desired, then please remerge ${PN} with USE=pam"
	fi
}
