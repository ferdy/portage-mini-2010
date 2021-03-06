# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/keepassx/keepassx-0.4.3.ebuild,v 1.4 2010/04/16 17:43:02 ranger Exp $

EAPI="2"

inherit qt4-r2

DESCRIPTION="Qt password manager compatible with its Win32 and Pocket PC versions."
HOMEPAGE="http://keepassx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug pch"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-xmlpatterns:4
	|| ( >=x11-libs/libXtst-1.1.0 <x11-proto/xextproto-7.1.0 )"
RDEPEND="${DEPEND}"

src_configure() {
	local conf_pch
	use pch && conf_pch="PRECOMPILED=1" || conf_pch="PRECOMPILED=0"

	eqmake4 ${PN}.pro -recursive \
		PREFIX="${D}/usr" \
		"${conf_pch}"
}

src_compile() {
	# workaround compile failure due to distcc, bug #214327
	PATH=${PATH/\/usr\/lib\/distcc\/bin:}
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc changelog || die "dodoc failed"
}
