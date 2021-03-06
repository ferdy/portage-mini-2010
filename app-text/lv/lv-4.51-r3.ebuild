# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lv/lv-4.51-r3.ebuild,v 1.1 2011/01/13 14:47:24 matsuu Exp $

EAPI="3"

inherit eutils toolchain-funcs

IUSE=""

MY_P="${PN}${PV//./}"

DESCRIPTION="Powerful Multilingual File Viewer"
HOMEPAGE="http://www.ff.iij4u.or.jp/~nrt/lv/"
SRC_URI="http://www.ff.iij4u.or.jp/~nrt/freeware/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
SLOT="0"
S="${WORKDIR}/${MY_P}"

RDEPEND="sys-libs/ncurses
	!app-editors/levee"
DEPEND="${RDEPEND}
	dev-lang/perl"

src_prepare() {

	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-xz.diff

}

src_configure() {

	ECONF_SOURCE=src econf || die

}
src_compile() {

	emake CC="$(tc-getCC)" || die

}

src_install() {

	emake DESTDIR="${D}" install || die

	dodoc README hello.sample || die
	dohtml index.html relnote.html hello.sample.gif || die

}
