# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libimobiledevice/libimobiledevice-1.0.0.ebuild,v 1.3 2010/05/28 10:10:04 maekke Exp $

EAPI=3

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python"

DEPEND="dev-util/pkgconfig
	${RDEPEND}"
RDEPEND=">=app-pda/libplist-1.1
	>=app-pda/usbmuxd-1.0.0_rc2
	>=dev-libs/glib-2.14.1
	dev-libs/libgcrypt
	net-libs/gnutls
	sys-fs/fuse
	virtual/libusb:0
	!app-pda/libiphone"

src_configure() {
	econf $(use_with python swig)
}

src_install() {
	make DESTDIR="${D}" install || die
}
