# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/crossdev/crossdev-0.9.18-r10.ebuild,v 1.4 2011/02/06 11:31:49 leio Exp $

DESCRIPTION="Gentoo Cross-toolchain generator"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=sys-apps/portage-2.1
	app-shells/bash
	|| ( dev-util/unifdef sys-freebsd/freebsd-ubin )"

src_install() {
	newsbin "${FILESDIR}"/crossdev-stable crossdev || die
	dosed "s:GENTOO_PV:${PV}:" /usr/sbin/crossdev
}
