# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ige-mac-integration/ige-mac-integration-0.8.2.ebuild,v 1.1 2010/09/30 10:32:22 grobian Exp $

EAPI="3"

inherit base python libtool

DESCRIPTION="GTK+ bindings for Mac OS X specific tasks"
LICENSE="LGPL-2"
HOMEPAGE="http://live.gnome.org/GTK+/OSX/Integration"
SRC_URI="http://ftp.imendio.com/pub/imendio/ige-mac-integration/${P}.tar.gz"
SLOT="0"
KEYWORDS="~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="x11-libs/gtk+
		dev-python/pygtk"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_prepare() {
	# fix the lookup of the codegen tools
	sed -e "s|\$(datadir)/pygtk/2.0|${EPREFIX}/$(python_get_sitedir)/gtk-2.0|g" \
		-i bindings/python/Makefile.am || die
	elibtoolize
}

src_configure() {
	econf --with-compile-warnings=no
}
