# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/socat/socat-2.0.0_beta4.ebuild,v 1.1 2010/08/02 02:37:43 jer Exp $

EAPI="2"

inherit eutils flag-o-matic

DESCRIPTION="Multipurpose relay (SOcket CAT)"
HOMEPAGE="http://www.dest-unreach.org/socat/"
MY_P=${P/_beta/-b}
S="${WORKDIR}/${MY_P}"
SRC_URI="http://www.dest-unreach.org/socat/download/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE="ssl readline ipv6 tcpd"

DEPEND="
	ssl? ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/ncurses-5.1 >=sys-libs/readline-4.1 )
	tcpd? ( sys-apps/tcp-wrappers )
"
RDEPEND="${DEPEND}"

src_configure() {
	filter-flags -Wall -Wno-error*
	econf \
		$(use_enable ssl openssl) \
		$(use_enable readline) \
		$(use_enable ipv6 ip6) \
		$(use_enable tcpd libwrap)
}

src_test() {
	TMPDIR="${T}" emake test || die 'self test failed'
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	dodoc BUGREPORTS CHANGES DEVELOPMENT \
		FAQ FILES PORTING README SECURITY VERSION
	docinto examples
	dodoc EXAMPLES *.sh
	dohtml doc/*.html doc/*.css
}