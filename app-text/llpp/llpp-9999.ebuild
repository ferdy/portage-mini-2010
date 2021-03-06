# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/llpp/llpp-9999.ebuild,v 1.4 2011/02/17 02:18:08 xmw Exp $

EAPI=3

EGIT_REPO_URI="git://repo.or.cz/llpp.git"

inherit git toolchain-funcs

DESCRIPTION="a graphical PDF viewer which aims to superficially resemble less(1)"
HOMEPAGE="http://repo.or.cz/w/llpp.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=app-text/mupdf-0.7_p20110212
	dev-ml/lablgl[glut]
	media-libs/jbig2dec
	media-libs/openjpeg
	x11-misc/xsel"
DEPEND="${RDEPEND}"

src_compile() {
	ocamlopt -c -o link.o -ccopt -O link.c || die
	ocamlopt -c -o main.cmo -I +lablGL main.ml || die

	ocamlopt -o llpp \
		-I +lablGL str.cmxa unix.cmxa lablgl.cmxa lablglut.cmxa link.o \
		-cclib "-lmupdf -lz -ljpeg -lopenjpeg -ljbig2dec -lfreetype -lpthread" \
		main.cmx || die
}

src_install() {
	dobin ${PN} || die
	dodoc KEYS Thanks fixme || die
}
