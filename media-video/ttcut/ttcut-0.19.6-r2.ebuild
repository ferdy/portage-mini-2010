# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ttcut/ttcut-0.19.6-r2.ebuild,v 1.3 2010/03/20 20:16:49 billie Exp $

EAPI=2

inherit eutils qt4-r2

DESCRIPTION="Tool for cutting MPEG files especially for removing commercials"
HOMEPAGE="http://www.tritime.de/ttcut/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	>=media-libs/libmpeg2-0.4.0
	virtual/opengl"

RDEPEND="${DEPEND}
	media-video/mplayer
	media-video/transcode[mjpeg]"

S=${WORKDIR}/${PN}

PATCHES=( "${FILESDIR}"/${P}-deprecated.patch
		"${FILESDIR}"/${P}-transcode-compat.patch )

src_install() {
	dobin ttcut || die
	make_desktop_entry ttcut TTCut "" "AudioVideo;Video;AudioVideoEditing"

	dodoc AUTHORS BUGS CHANGELOG README.* TODO || die
}
