# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/altermime/altermime-0.3.10-r1.ebuild,v 1.3 2011/02/08 17:42:38 tomka Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION=" alterMIME is a small program which is used to alter your mime-encoded mailpacks"
SRC_URI="http://www.pldaniels.com/altermime/${P}.tar.gz"
HOMEPAGE="http://pldaniels.com/altermime/"

LICENSE="Sendmail"
SLOT="0"
KEYWORDS="amd64 ~ppc ~s390 x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-fprintf-fixes.patch \
		"${FILESDIR}"/${P}-MIME_headers-overflow.patch \
		"${FILESDIR}"/${P}-respect-flags.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install () {
	dobin altermime || die
	dodoc CHANGELOG README || die
}
