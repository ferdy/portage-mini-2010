# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/analog/analog-6.0-r4.ebuild,v 1.1 2010/09/18 03:27:45 jer Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="A webserver log analyzer"
HOMEPAGE="http://www.analog.cx/"
SRC_URI="http://www.analog.cx/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/libpcre-3.4
	>=media-libs/gd-1.8.4-r2[jpeg,png]
	sys-libs/zlib
	media-libs/jpeg:0
	media-libs/libpng"
RDEPEND="${DEPEND}"

src_prepare() {
	cd src/
	epatch "${FILESDIR}/${PN}-5.1-gentoo.diff"
	epatch "${FILESDIR}/${P}-bzip2.patch"
	sed -i Makefile \
		-e 's| -o | $(LDFLAGS)&|g' \
		|| die "sed Makefile"
}

src_compile() {
	tc-export CC
	emake || die "make failed"
}

src_install() {
	dobin analog || die "dobin failed"
	newman analog.man analog.1

	dodoc README.txt Licence.txt analog.cfg
	dohtml -a html,gif,css,ico docs/*
	dohtml -r how-to
	docinto examples ; dodoc examples/*
	docinto cgi ; dodoc anlgform.pl

	insinto /usr/share/analog/images ; doins images/*
	insinto /usr/share/analog/lang ; doins lang/*
	dodir /var/log/analog
	dosym /usr/share/analog/images /var/log/analog/images
	insinto /etc/analog ; doins "${FILESDIR}/analog.cfg"
}
