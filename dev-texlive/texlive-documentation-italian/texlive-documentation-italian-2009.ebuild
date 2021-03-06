# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-italian/texlive-documentation-italian-2009.ebuild,v 1.2 2010/02/02 21:30:18 abcd Exp $

TEXLIVE_MODULE_CONTENTS="amsldoc-it amsmath-it amsthdoc-it fancyhdr-it l2tabu-it lshort-italian psfrag-italian texlive-it collection-documentation-italian
"
TEXLIVE_MODULE_DOC_CONTENTS="amsldoc-it.doc amsmath-it.doc amsthdoc-it.doc fancyhdr-it.doc l2tabu-it.doc lshort-italian.doc psfrag-italian.doc texlive-it.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Italian documentation"

LICENSE="GPL-2 GPL-1 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2009
"
RDEPEND="${DEPEND} "
