# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/language-c/language-c-0.3.1.1.ebuild,v 1.8 2010/11/14 19:22:35 slyfox Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Analysis and generation of C code"
HOMEPAGE="http://www.sivity.net/projects/language.c/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1"
DEPEND="${RDEPEND}
		dev-haskell/happy
		dev-haskell/alex
		>=dev-haskell/cabal-1.2.3"
