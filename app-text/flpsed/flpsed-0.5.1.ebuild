# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/flpsed/flpsed-0.5.1.ebuild,v 1.4 2009/12/26 17:30:19 pva Exp $

EAPI=1

DESCRIPTION="Pseudo PostScript editor"
HOMEPAGE="http://www.ecademix.com/JohannesHofmann/"
SRC_URI="http://www.ecademix.com/JohannesHofmann/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	>=x11-libs/fltk-1.1:1.1
	app-text/ghostscript-gpl"

DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog NEWS AUTHORS
}
