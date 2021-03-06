# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/cromwell/cromwell-2.40-r3.ebuild,v 1.4 2009/03/08 19:17:51 vapier Exp $

inherit eutils mount-boot

DESCRIPTION="Xbox boot loader"
HOMEPAGE="http://www.xbox-linux.org/wiki/Cromwell"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${PF}-cvs-fixes.patch.lzma"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="strip"

PROVIDE="virtual/bootloader"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${PF}-cvs-fixes.patch
	sed -i 's:-Werror::' Makefile Rules.make
}

src_compile() {
	emake -j1 || die
}

src_install() {
	insinto /boot/${PN}
	doins image/cromwell{,_1024}.bin xbe/xromwell.xbe || die
}
