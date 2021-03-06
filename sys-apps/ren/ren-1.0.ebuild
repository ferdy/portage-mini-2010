# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ren/ren-1.0.ebuild,v 1.23 2010/01/07 21:50:56 fauli Exp $

DESCRIPTION="Renames multiple files"
HOMEPAGE="http://freshmeat.net/projects/ren"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/file/${P}.tar.gz"

KEYWORDS="alpha amd64 ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""
SLOT="0"
LICENSE="as-is"

DEPEND=""

src_compile() {
	emake || die
}

src_install() {
	dobin ren
	dodoc README
	doman ren.1
}
