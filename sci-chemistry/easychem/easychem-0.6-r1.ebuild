# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/easychem/easychem-0.6-r1.ebuild,v 1.2 2010/10/03 08:30:26 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Chemical structure drawing program - focused on presentation"
HOMEPAGE="http://easychem.sourceforge.net/"
SRC_URI="mirror://sourceforge/easychem/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	>=x11-libs/gtk+-2.4.1
	app-text/ghostscript-gpl
	media-gfx/pstoedit"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gentoo.patch
	tc-export CC
}

src_compile() {
	ln -s Makefile.linux Makefile
	DGS_PATH="${EPREFIX}"/usr/bin DPSTOEDIT_PATH="${EPREFIX}"/usr/bin \
		C_FLAGS="${CFLAGS}" emake -e || die
}

src_install () {
	dobin easychem || die
	dodoc TODO || die
}
