# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gts/gts-20090909.ebuild,v 1.1 2010/01/15 07:14:10 bicatali Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="GNU Triangulated Surface Library"
LICENSE="LGPL-2"
HOMEPAGE="http://gts.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples test"

RDEPEND=">=dev-libs/glib-2.4.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( media-libs/netpbm )"

# tests are failing
RESTRICT="test"

S="${WORKDIR}"/${PN}-snapshot-090909

src_prepare() {
	chmod +x test/*/*.sh
	epatch "${FILESDIR}"/${P}-examples.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c || die "Failed to install examples"
	fi

	# install additional docs
	if use doc; then
		dohtml doc/html/*
	fi
}
