# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxpanel/lxpanel-0.5.6.ebuild,v 1.8 2011/01/22 14:13:54 xarthisius Exp $

EAPI="2"
inherit eutils autotools

DESCRIPTION="Lightweight X11 desktop panel for LXDE"
HOMEPAGE="http://lxde.org/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 arm ppc x86 ~x86-interix ~amd64-linux ~x86-linux"
SLOT="0"
IUSE="+alsa"
RESTRICT="test"  # bug 249598

RDEPEND="x11-libs/gtk+:2
	x11-libs/libXmu
	x11-libs/libXpm
	lxde-base/lxmenu-data
	lxde-base/menu-cache
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.5.1-sandbox.patch
	epatch "${FILESDIR}"/${P}-symbol-alarm.patch
	epatch "${FILESDIR}"/${P}-broken-apps.patch
	eautoreconf
}

src_configure() {
	local plugins=all
	[[ ${CHOST} == *-interix* ]] && plugins=deskno,kbled,xkb

	econf $(use_enable alsa) --with-x --with-plugins=${plugins}
	# the gtk+ dep already pulls in libX11, so we might as well hardcode with-x
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"

	# Get rid of the .la files.
	find "${D}" -name '*.la' -delete
}

pkg_postinst() {
	elog "If you have problems with broken icons shown in the main panel,"
	elog "you will have to configure panel settings via its menu."
	elog "This will not be an issue with first time installations."
}
