# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-wikipedia/gmpc-wikipedia-0.20.0.ebuild,v 1.3 2011/02/20 17:44:11 phajdan.jr Exp $

EAPI=2

DESCRIPTION="This plugin shows the Wikipedia article about the currently playing artist"
HOMEPAGE="http://gmpc.wikia.com/wiki/GMPC_PLUGIN_WIKIPEDIA"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2
	net-libs/webkit-gtk"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool
		sys-devel/gettext )"

src_configure() {
	econf \
		$(use_enable nls) \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
}
