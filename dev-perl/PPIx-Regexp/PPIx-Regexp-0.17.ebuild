# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PPIx-Regexp/PPIx-Regexp-0.17.ebuild,v 1.1 2011/02/08 06:34:42 tove Exp $

EAPI=3

MODULE_AUTHOR=WYANT
MODULE_VERSION=0.017
inherit perl-module

DESCRIPTION="Represent a regular expression of some sort"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/List-MoreUtils
	dev-perl/PPI
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
