# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/prelude-lml/prelude-lml-0.9.10.1.ebuild,v 1.7 2011/01/10 20:56:09 tomka Exp $

inherit flag-o-matic

DESCRIPTION="Prelude-IDS Log Monitoring Lackey"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc ~x86"
IUSE="fam"

DEPEND=">=dev-libs/libprelude-0.9.9
	dev-libs/libpcre"

RDEPEND="${DEPEND}"

src_compile() {
	local myconf

	use fam && myconf="${myconf} --with-fam"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	newinitd "${FILESDIR}"/gentoo.init prelude-lml
	newconfd "${FILESDIR}"/gentoo.conf prelude-lml
}
