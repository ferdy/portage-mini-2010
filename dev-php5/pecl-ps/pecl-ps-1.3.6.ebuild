# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-ps/pecl-ps-1.3.6.ebuild,v 1.2 2011/01/30 16:39:35 armin76 Exp $

EAPI=3

PHP_EXT_NAME="ps"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DESCRIPTION="PHP extension for creating PostScript files."
LICENSE="PHP-2.02"
SLOT="0"
IUSE="examples"

DEPEND="dev-libs/pslib"
RDEPEND="${DEPEND}"
