# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Vec/Math-Vec-1.01.ebuild,v 1.4 2009/08/14 21:54:16 maekke Exp $

MODULE_AUTHOR=EWILHELM
inherit perl-module

DESCRIPTION="vectors for perl"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 x86"
IUSE="test"

SRC_TEST="do"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple )"
