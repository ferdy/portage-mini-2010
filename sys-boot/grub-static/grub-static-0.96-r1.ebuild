# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/grub-static/grub-static-0.96-r1.ebuild,v 1.3 2010/11/30 08:14:50 robbat2 Exp $

DESCRIPTION="Static GNU GRUB boot loader"

HOMEPAGE="http://www.gnu.org/software/grub/"
SRC_URI="mirror://gentoo/grub-static-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 ~x86"
IUSE=""
DEPEND="!sys-boot/grub"
RDEPEND="${DEPEND}"
PROVIDE="virtual/bootloader"

src_install() {
	cp -a "${WORKDIR}"/* "${D}"/
}
