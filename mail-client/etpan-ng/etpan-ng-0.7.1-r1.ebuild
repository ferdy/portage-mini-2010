# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/etpan-ng/etpan-ng-0.7.1-r1.ebuild,v 1.1 2010/04/20 19:08:07 fauli Exp $

inherit eutils autotools

DESCRIPTION="etPan is a console mail client that is based on libEtPan!"
HOMEPAGE="http://libetpan.sourceforge.net/etpan/"
SRC_URI="mirror://sourceforge/libetpan/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug ldap"

DEPEND=">=net-libs/libetpan-0.35
	sys-libs/ncurses
	ldap? ( net-nds/openldap )
	|| ( sys-devel/bison dev-util/yacc dev-util/byacc )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	eautoreconf
}

src_compile() {
	sed -i -e "s:@bindir@:${D}/@bindir@:" src/Makefile.in

	econf \
		`use_enable debug` \
			|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc Changelog NEWS README TODO contrib/etpan-make-vtree.pl doc/*
}
