# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/rblcheck/rblcheck-1.5-r1.ebuild,v 1.1 2010/07/10 22:03:37 hwoarang Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="Perform lookups in RBL-styles services."
HOMEPAGE="http://rblcheck.sourceforge.net/"
SRC_URI="mirror://sourceforge/rblcheck/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${P}-configure.patch"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install () {
	exeinto /usr/bin
	doexe rbl rblcheck

	dodoc README docs/rblcheck.ps docs/rblcheck.rtf
}
