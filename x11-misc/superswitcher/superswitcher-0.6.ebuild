# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/superswitcher/superswitcher-0.6.ebuild,v 1.5 2010/09/27 10:36:55 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A more feature-full replacement of the Alt-Tab window switching behavior."
HOMEPAGE="http://code.google.com/p/superswitcher/"
SRC_URI="http://superswitcher.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/dbus-glib
	dev-libs/glib:2
	>=gnome-base/gconf-2
	x11-libs/gtk+:2
	>=x11-libs/libwnck-2.10
	x11-libs/libXcomposite
	x11-libs/libXinerama
	x11-libs/libXrender"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	gnome-base/gnome-common"

src_prepare() {
	sed -i \
		-e '/-DG.*_DISABLE_DEPRECATED/d' \
		src/Makefile.am || die #338906
	epatch "${FILESDIR}"/${P}-wnck-workspace.patch
	eautoreconf
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}
