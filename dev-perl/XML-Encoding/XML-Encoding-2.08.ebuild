# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Encoding/XML-Encoding-2.08.ebuild,v 1.1 2010/09/21 17:47:50 tove Exp $

MODULE_AUTHOR=SHAY
inherit perl-module

DESCRIPTION="Perl Module that parses encoding map XML files"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/XML-Parser
	dev-lang/perl"

SRC_TEST=do