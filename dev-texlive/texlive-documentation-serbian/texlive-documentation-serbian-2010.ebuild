# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-serbian/texlive-documentation-serbian-2010.ebuild,v 1.5 2011/02/20 09:59:53 xarthisius Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="texlive-sr collection-documentation-serbian
"
TEXLIVE_MODULE_DOC_CONTENTS="texlive-sr.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Serbian documentation"

LICENSE="GPL-2 "
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2010
"
RDEPEND="${DEPEND} "
