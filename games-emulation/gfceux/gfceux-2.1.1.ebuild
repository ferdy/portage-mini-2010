# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gfceux/gfceux-2.1.1.ebuild,v 1.3 2010/04/28 08:28:55 tupone Exp $

EAPI=2
PYTHON_DEPEND="2:2.5"
inherit eutils python distutils games

DESCRIPTION="A graphical frontend for the FCEUX emulator"
HOMEPAGE="http://fceux.com"
SRC_URI="mirror://sourceforge/fceultra/fceux-${PV}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/pygtk"
RDEPEND="${DEPEND}
	games-emulation/fceux"

S=${WORKDIR}/${PN}

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
	distutils_src_prepare
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install \
		--install-scripts="${GAMES_BINDIR}"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	distutils_pkg_postinst
}
