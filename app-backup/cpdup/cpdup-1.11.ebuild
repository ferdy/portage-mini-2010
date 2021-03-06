# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/cpdup/cpdup-1.11.ebuild,v 1.1 2009/02/05 11:54:05 drizzt Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A comprehensive filesystem mirroring program"
HOMEPAGE="http://apollo.backplane.com/FreeSrc/"
SRC_URI="http://apollo.backplane.com/FreeSrc/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86-fbsd ~amd64"
IUSE="userland_GNU threads"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-explicit_sizes.patch	# Patch from Fedora bug #435508
	epatch "${FILESDIR}"/${P}-unused.patch

	if use userland_GNU; then
		cp "${FILESDIR}"/Makefile.linux Makefile
		# bits/stat.h has __unused too
		sed -i 's/__unused/__cpdup_unused/' *.c
	fi
	rm -r scripts/CVS
}

src_compile() {
	tc-export CC
	use threads || MAKEOPTS="$MAKEOPTS NOPTHREADS=1"
	MAKE=make emake || die "emake failed"
}

src_install() {
	dobin cpdup || die "cannot install cpdup"
	doman cpdup.1
	docinto scripts
	dodoc scripts/*
}
