# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-science/texlive-science-2010.ebuild,v 1.2 2011/01/18 20:05:23 grobian Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="SIstyle SIunits alg algorithm2e algorithmicx algorithms biocon bpchem bytefield chemarrow chemcompounds chemcono chemstyle clrscode complexity computational-complexity digiconfigs drawstack dyntree eltex engtlc fouridx functan galois gastex gene-logic gu hep hepnames hepparticles hepthesis hepunits karnaugh mhchem mhs miller objectz pseudocode scientificpaper sciposter sfg siunitx steinmetz struktex t-angles textopo ulqda unitsdef youngtab collection-science
"
TEXLIVE_MODULE_DOC_CONTENTS="SIstyle.doc SIunits.doc alg.doc algorithm2e.doc algorithmicx.doc algorithms.doc biocon.doc bpchem.doc bytefield.doc chemarrow.doc chemcompounds.doc chemcono.doc chemstyle.doc clrscode.doc complexity.doc computational-complexity.doc digiconfigs.doc drawstack.doc dyntree.doc eltex.doc engtlc.doc fouridx.doc functan.doc galois.doc gastex.doc gene-logic.doc gu.doc hep.doc hepnames.doc hepparticles.doc hepthesis.doc hepunits.doc karnaugh.doc mhchem.doc miller.doc objectz.doc pseudocode.doc scientificpaper.doc sciposter.doc sfg.doc siunitx.doc steinmetz.doc struktex.doc t-angles.doc textopo.doc ulqda.doc unitsdef.doc youngtab.doc "
TEXLIVE_MODULE_SRC_CONTENTS="SIstyle.source SIunits.source alg.source algorithms.source bpchem.source bytefield.source chemarrow.source chemcompounds.source chemstyle.source computational-complexity.source dyntree.source fouridx.source functan.source galois.source miller.source objectz.source siunitx.source steinmetz.source struktex.source textopo.source ulqda.source unitsdef.source youngtab.source "
inherit texlive-module
DESCRIPTION="TeXLive Typesetting for natural and computer sciences"

LICENSE="GPL-2 as-is GPL-1 LGPL-2 LPPL-1.2 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~ppc-macos"
IUSE=""
DEPEND=">=dev-texlive/texlive-latex-2010
!dev-tex/SIunits
"
RDEPEND="${DEPEND} dev-texlive/texlive-pstricks
"
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/ulqda/ulqda.pl"
