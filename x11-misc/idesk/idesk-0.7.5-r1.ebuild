# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/idesk/idesk-0.7.5-r1.ebuild,v 1.10 2010/07/21 14:36:41 ssuominen Exp $

EAPI=2

DESCRIPTION="Utility to place icons on the root window"
HOMEPAGE="http://idesk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/imlib2-1.4[X]
	media-libs/freetype
	dev-libs/libxml2
	dev-libs/glib:2
	gnome-extra/libgsf
	x11-libs/pango
	x11-libs/gtk+:2
	media-libs/libart_lgpl
	x11-libs/startup-notification"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i \
		-e 's,/usr/local/,/usr/,' \
		examples/default.lnk || die
}

src_configure() {
	econf \
		--enable-libsn
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README AUTHORS NEWS TODO
}
