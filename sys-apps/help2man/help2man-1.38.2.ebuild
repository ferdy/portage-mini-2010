# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/help2man/help2man-1.38.2.ebuild,v 1.7 2011/01/29 16:45:07 armin76 Exp $

EAPI="2"

inherit eutils

DESCRIPTION="GNU utility to convert program --help output to a man page"
HOMEPAGE="http://www.gnu.org/software/help2man"
SRC_URI="mirror://gnu/help2man/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="nls elibc_glibc"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	elibc_glibc? ( nls? (
		dev-perl/Locale-gettext
		>=sys-devel/gettext-0.12.1-r1
	) )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.36.4-respect-LDFLAGS.patch
	epatch "${FILESDIR}"/${PN}-1.38.2-build.patch
}

src_configure() {
	local myconf
	use elibc_glibc \
		&& myconf="${myconf} $(use_enable nls)" \
		|| myconf="${myconf} --disable-nls"
	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README THANKS
}
