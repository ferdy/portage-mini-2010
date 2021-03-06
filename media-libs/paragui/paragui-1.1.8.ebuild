# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/paragui/paragui-1.1.8.ebuild,v 1.14 2010/11/11 10:14:02 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A cross-platform high-level application framework and GUI library"
HOMEPAGE="http://www.paragui.org/"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	=dev-libs/libsigc++-1.2*
	>=media-libs/freetype-2
	>=media-libs/libpng-1.4
	dev-games/physfs
	virtual/jpeg
	dev-libs/expat
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-header.patch \
		"${FILESDIR}"/${P}-asneeded.patch \
		"${FILESDIR}"/${P}-gcc43.patch

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README* doc/{RELEASENOTES,TODO}
	newdoc TODO ROADMAP
}
