# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/String-Ediff/String-Ediff-0.09.ebuild,v 1.5 2007/11/10 14:35:50 drac Exp $

inherit perl-module

DESCRIPTION="Produce common sub-string indices for two strings"
SRC_URI="mirror://cpan/authors/id/B/BO/BOXZOU/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~boxzou/String-Ediff-0.08/"
SRC_TEST="do"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
