# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ostinato/ostinato-0.3.ebuild,v 1.3 2010/12/18 12:09:20 hwoarang Exp $

EAPI=2
inherit qt4-r2

DESCRIPTION="A packet generator and analyzer"
HOMEPAGE="http://code.google.com/p/ostinato/"
SRC_URI="http://ostinato.googlecode.com/files/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/protobuf
	net-libs/libpcap
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-script:4"
RDEPEND="${DEPEND}"

src_configure(){
	eqmake4 PREFIX=/usr ost.pro
}
