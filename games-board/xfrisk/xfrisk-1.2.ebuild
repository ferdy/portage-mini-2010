# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xfrisk/xfrisk-1.2.ebuild,v 1.9 2010/09/17 06:28:13 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="The RISK board game"
HOMEPAGE="http://tuxick.net/xfrisk/"
SRC_URI="http://tuxick.net/xfrisk/files/XFrisk-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/libXmu
	x11-libs/Xaw3d"
DEPEND="${RDEPEND}
	x11-libs/libXaw"

S=${WORKDIR}/XFrisk

src_prepare() {
	sed -i \
		-e '/^CC=/d' \
		-e '/^LDFLAGS=/d' \
		-e "/^CFLAGS=/s|=.*|=${CFLAGS}|" \
		-e "s:/usr/local:${GAMES_PREFIX}:" \
		Makefile \
		|| die
}

src_install() {
	emake PREFIX="${D}/${GAMES_PREFIX}" install || die
	dodoc BUGS ChangeLog FAQ TODO
	prepgamesdirs
}
