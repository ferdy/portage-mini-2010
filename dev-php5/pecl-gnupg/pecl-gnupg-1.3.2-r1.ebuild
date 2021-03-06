# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-gnupg/pecl-gnupg-1.3.2-r1.ebuild,v 1.2 2011/01/26 23:10:29 mabi Exp $

PHP_EXT_NAME="gnupg"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

EAPI="3"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"
DESCRIPTION="PHP wrapper around the gpgme library"
LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND="app-crypt/gpgme"
RDEPEND="${DEPEND}"

src_prepare() {
	for slot in $(php_get_slots); do
		php_init_slot_env ${slot}
		epatch "${FILESDIR}/${PV}"/01-large_file_system.patch
	done

	php-ext-source-r2_src_prepare
}
