# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-gl/aspell-gl-0.5.0.ebuild,v 1.1 2010/02/19 09:32:21 pva Exp $

ASPELL_LANG="Galician"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

MY_P=${P%.*}0-${PV##*.}
MY_P=aspell${ASPOSTFIX}-${MY_P/aspell-/}
S=${WORKDIR}/${MY_P}
SRC_URI="mirror://gnu/aspell/dict/${SPELLANG}/${MY_P}.tar.bz2"
