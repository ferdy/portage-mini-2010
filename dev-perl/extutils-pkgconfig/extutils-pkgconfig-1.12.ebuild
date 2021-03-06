# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-pkgconfig/extutils-pkgconfig-1.12.ebuild,v 1.4 2010/01/09 19:59:13 grobian Exp $

MODULE_AUTHOR=TSCH
MY_PN=ExtUtils-PkgConfig
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

inherit perl-module

DESCRIPTION="Simplistic perl interface to pkg-config"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

DEPEND="dev-lang/perl
	dev-util/pkgconfig"
RDEPEND="${DEPEND}"

SRC_TEST="do"
