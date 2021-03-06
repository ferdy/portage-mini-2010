# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irqbalance/irqbalance-0.56.ebuild,v 1.3 2011/01/21 15:25:09 vapier Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="Distribute hardware interrupts across processors on a multiprocessor system"
HOMEPAGE="http://www.irqbalance.org/"
SRC_URI="http://irqbalance.googlecode.com/files/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="caps"

RDEPEND="dev-libs/glib:2
	caps? ( sys-libs/libcap-ng )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	mv cap-ng.m4 acinclude.m4 || die
	eautoreconf
}

src_configure() {
	econf \
		--sbindir=/sbin \
		$(use_with caps libcap-ng)
}

src_install() {
	emake install DESTDIR="${D}" || die
	newinitd "${FILESDIR}"/irqbalance.init-0.55-r2 irqbalance || die
	newconfd "${FILESDIR}"/irqbalance.confd irqbalance
}
