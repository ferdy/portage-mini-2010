# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sil-charis/sil-charis-4.100.ebuild,v 1.1 2008/05/19 00:50:41 dirtyepic Exp $

inherit font

MY_PN="CharisSIL"

DESCRIPTION="SIL Charis - SIL fonts for Roman and Cyrillic languages"
HOMEPAGE="http://scripts.sil.org/CharisSILfont"
SRC_URI="mirror://gentoo/${MY_PN}${PV}.zip"

LICENSE="OFL"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="doc"

DEPEND="app-arch/unzip"

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="OFL-FAQ.txt"

src_install() {
	font_src_install
	use doc && dodoc *.pdf
}
