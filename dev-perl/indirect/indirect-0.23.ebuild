# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/indirect/indirect-0.23.ebuild,v 1.1 2011/01/30 23:21:41 idl0r Exp $

EAPI="3"

MODULE_AUTHOR="VPIT"

inherit perl-module

DESCRIPTION="Lexically warn about using the indirect object syntax"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
