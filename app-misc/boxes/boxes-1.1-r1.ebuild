# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/boxes/boxes-1.1-r1.ebuild,v 1.5 2010/10/24 15:54:26 ranger Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Draw any kind of boxes around your text"
HOMEPAGE="http://boxes.thomasjensen.com/"
SRC_URI="http://boxes.thomasjensen.com/download/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~mips ppc ~ppc64 sparc x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PV}-Makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin src/boxes || die
	doman doc/boxes.1 || die
	dodoc README || die
	insinto /usr/share/boxes
	doins boxes-config || die
}
