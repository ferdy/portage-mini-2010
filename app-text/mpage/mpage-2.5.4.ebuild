# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mpage/mpage-2.5.4.ebuild,v 1.7 2008/12/30 21:39:32 angelos Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Many to one page printing utility"
HOMEPAGE="http://www.mesa.nl/"
SRC_URI="http://www.mesa.nl/pub/${PN}/${P}.tgz"

KEYWORDS="amd64 ppc sparc x86"
LICENSE="freedist"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-gcc4.patch
}

src_compile() {
	emake \
		CFLAGS="$CFLAGS \$(DEFS)" \
		CC="$(tc-getCC)" \
		PREFIX=/usr \
		MANDIR=/usr/share/man/man1 || die "emake failed"
}

src_install () {
	emake \
		PREFIX="${D}/usr" \
		MANDIR="${D}/usr/share/man/man1" install || die "make install failed"
	dodoc CHANGES Encoding.format FAQ NEWS README TODO || die "dodoc failed"
}
