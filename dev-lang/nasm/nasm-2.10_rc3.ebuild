# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nasm/nasm-2.10_rc3.ebuild,v 1.1 2011/01/17 01:57:57 mr_bones_ Exp $

EAPI=2
inherit flag-o-matic

DESCRIPTION="groovy little assembler"
HOMEPAGE="http://nasm.sourceforge.net/"
SRC_URI="http://www.nasm.us/pub/nasm/releasebuilds/${PV/_}/${P/_}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-macos"
IUSE="doc"

DEPEND="dev-lang/perl
	doc? ( app-text/ghostscript-gpl sys-apps/texinfo )"
RDEPEND=""

S=${WORKDIR}/${P/_}

src_prepare() {
	sed -i -e '/^.PHONY: all/s/$/ test/' Makefile.in || die
}

src_configure() {
	strip-flags
	econf
}

src_compile() {
	emake nasmlib.o || die
	emake all || die
	if use doc ; then
		emake doc || die
	fi
}

src_install() {
	emake INSTALLROOT="${D}" install install_rdf || die
	dodoc AUTHORS CHANGES ChangeLog README TODO
	if use doc ; then
		doinfo doc/info/*
		dohtml doc/html/*
		dodoc doc/nasmdoc.*
	fi
}
