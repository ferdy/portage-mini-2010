# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-MDB2_Driver_pgsql/PEAR-MDB2_Driver_pgsql-1.5.0_beta3.ebuild,v 1.1 2010/09/11 14:29:13 mabi Exp $

EAPI="2"

inherit php-pear-r1

DESCRIPTION="Database Abstraction Layer, pgsql driver"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=dev-php/PEAR-MDB2-2.5.0_beta3
		dev-lang/php[postgres]"
RDEPEND="${DEPEND}"