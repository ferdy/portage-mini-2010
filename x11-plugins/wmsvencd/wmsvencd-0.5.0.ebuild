# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsvencd/wmsvencd-0.5.0.ebuild,v 1.9 2010/08/31 10:51:13 s4t4n Exp $

inherit eutils

IUSE=""

DESCRIPTION="Window Maker Dockable CD-Player with CDDB"
SRC_URI="http://www.harshbutfair.org/dl/${P}.tar.gz"
HOMEPAGE="http://www.harshbutfair.org/software/wmsvencd.html"

DEPEND="x11-wm/windowmaker
	x11-libs/libXpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

src_unpack() {

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/wmsvencd-compile.patch

	sed -i 's:c++ -o:c++ $(LDFLAGS) -o:' Makefile
}

src_compile() {

	emake CFLAGS="${CFLAGS} -fno-strength-reduce" || die "make failed"

}

src_install() {

	newman wmsvencd.1x wmsvencd.1
	dobin wmsvencd
	dodoc README

	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop
}
