# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/slrn/slrn-0.9.9_p1.ebuild,v 1.6 2010/10/16 13:57:44 ranger Exp $

EAPI=2
inherit eutils

MY_P=${P/_}

DESCRIPTION="A s-lang based newsreader"
HOMEPAGE="http://slrn.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="nls ssl uudeview"

RDEPEND="virtual/mta
	app-arch/sharutils
	>=sys-libs/slang-2.1.3
	ssl? ( dev-libs/openssl )
	uudeview? ( dev-libs/uulib )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-dont-strip.patch
}

src_configure() {
	econf \
		--with-docdir=/usr/share/doc/${PF} \
		--with-slrnpull \
		$(use_with uudeview) \
		$(use_enable nls) \
		$(use_with ssl)
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
	prepalldocs
}
