# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/safecat/safecat-1.13.ebuild,v 1.1 2010/11/07 22:49:13 radhermit Exp $

EAPI="3"

inherit fixheadtails eutils toolchain-funcs flag-o-matic

DESCRIPTION="Safecat implements qmail's maildir algorithm, copying standard input safely to a specified directory"
HOMEPAGE="http://www.jeenyus.net/linux/software/safecat.html"
SRC_URI="http://www.jeenyus.net/linux/software/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-apps/groff"
RDEPEND=""

src_prepare() {
	# applying maildir-patch
	epatch "${FILESDIR}"/safecat-1.11-gentoo.patch

	# Fix parallel make errors
	epatch "${FILESDIR}"/${P}-makefile.patch

	ht_fix_file Makefile make-compile.sh

	sed -ni '/man\|doc/!p' hier.c
}

src_configure() {
	# safecat segfaults on gcc-4.0 x86 with -Os, seems to be okay with -O2
	if [[ $(gcc-major-version).$(gcc-minor-version) == 4.0 ]]; then
		replace-flags -Os -O2
	fi

	echo "/usr" > conf-root
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
}

src_install() {
	dodir /usr
	echo "${D}/usr" > conf-root
	emake setup check || die
	dodoc CHANGES README
	doman maildir.1 safecat.1
}
