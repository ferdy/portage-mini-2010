# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/catalyst/catalyst-2.0.6.913.ebuild,v 1.1 2010/11/01 17:42:10 armin76 Exp $

inherit eutils multilib
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wolf31o2.org/sources/${PN}/${P}.tar.bz2"

DESCRIPTION="release metatool used for creating releases based on Gentoo Linux"
HOMEPAGE="http://wolf31o2.org/projects/catalyst"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
#KEYWORDS=""
RESTRICT=""
IUSE="ccache"

DEPEND=""
RDEPEND="dev-lang/python
	app-crypt/shash
	virtual/cdrtools
	ccache? ( dev-util/ccache )
	ia64? ( sys-fs/dosfstools )
	kernel_linux? ( app-misc/zisofs-tools >=sys-fs/squashfs-tools-2.1 )"

pkg_setup() {
	if use ccache ; then
		einfo "Enabling ccache support for catalyst."
	else
		ewarn "By default, ccache support for catalyst is disabled."
		ewarn "If this is not what you intended,"
		ewarn "then you should add ccache to your USE."
	fi
	echo
	einfo "The template spec files are now installed by default.  You can find"
	einfo "them under /usr/share/doc/${PF}/examples"
	einfo "and they are considered to be the authorative source of information"
	einfo "on catalyst."
}

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_install() {
	insinto /usr/$(get_libdir)/${PN}
	exeinto /usr/$(get_libdir)/${PN}
	doexe catalyst || die "copying catalyst"
	doins -r arch modules livecd || die "copying files"
	for x in targets/*; do
		exeinto /usr/$(get_libdir)/${PN}/$x
		doexe $x/* || die "copying ${x}"
	done
	make_wrapper catalyst /usr/$(get_libdir)/${PN}/catalyst
	insinto /etc/catalyst
	doins files/catalyst.conf files/catalystrc || die "copying configuration"
	insinto /usr/share/doc/${PF}/examples
	doins examples/* || die
	dodoc README ChangeLog AUTHORS
	doman files/catalyst.1
	# Here is where we actually enable ccache
	use ccache && \
		dosed 's:options="autoresume kern:options="autoresume ccache kern:' \
		/etc/catalyst/catalyst.conf
	dosed "s:/usr/lib/catalyst:/usr/$(get_libdir)/catalyst:" \
		/etc/catalyst/catalyst.conf
}

pkg_postinst() {
	einfo "You can find more information about catalyst by checking out the"
	einfo "catalyst project page at:"
	einfo "http://www.gentoo.org/proj/en/releng/catalyst/index.xml"
	echo
}
