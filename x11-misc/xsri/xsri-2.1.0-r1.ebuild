# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsri/xsri-2.1.0-r1.ebuild,v 1.9 2010/10/10 10:20:47 phajdan.jr Exp $

EAPI=2
inherit autotools rpm

DESCRIPTION="The xsri wallpaper setter from RedHat"
HOMEPAGE="http://fedora.redhat.com/"
SRC_URI="mirror://fedora/5/source/SRPMS/${P}-9.2.1.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i -e '/-DG.*_DISABLE_DEPRECATED/d' Makefile.am || die
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README
}
