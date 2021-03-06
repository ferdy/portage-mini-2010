# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hearnet/hearnet-0.0.2.ebuild,v 1.10 2009/06/05 10:46:00 ssuominen Exp $

IUSE=""

DESCRIPTION="Listen to your network"
HOMEPAGE="http://falcon.fugal.net/~fugalh/hearnet/"
SRC_URI="http://falcon.fugal.net/~fugalh/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
#-amd64: 0.0.2: No sound sent to jack server
KEYWORDS="x86 -amd64 ~ppc"

RDEPEND="virtual/libpcap
	media-sound/jack-audio-connection-kit"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's!grain.raw!/usr/share/hearnet/grain.raw!' hearnet.c
}

src_compile() {
	emake || die "emake failed"
}

src_install () {
	dosbin hearnet

	dodir /usr/share/hearnet
	insinto /usr/share/hearnet && doins grain.raw

	dodoc ChangeLog README TODO
}
