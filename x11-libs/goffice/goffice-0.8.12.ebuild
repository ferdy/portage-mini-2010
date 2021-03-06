# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/goffice/goffice-0.8.12.ebuild,v 1.3 2011/01/13 19:59:45 pacho Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit eutils gnome2 flag-o-matic

DESCRIPTION="A library of document-centric objects and utilities"
HOMEPAGE="http://freshmeat.net/projects/goffice/"

LICENSE="GPL-2"
SLOT="0.8"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x64-solaris"
IUSE="doc gnome"

# Build fails with -gtk
# FIXME: add lasem to tree
RDEPEND=">=dev-libs/glib-2.16:2
	>=gnome-extra/libgsf-1.14.9
	>=dev-libs/libxml2-2.4.12
	>=x11-libs/pango-1.8.1
	>=x11-libs/cairo-1.2[svg]
	x11-libs/libXext
	x11-libs/libXrender
	>=x11-libs/gtk+-2.16:2
	gnome? ( >=gnome-base/gconf-2 )
"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.18
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1.11 )"

pkg_setup() {
	DOCS="AUTHORS BUGS ChangeLog MAINTAINERS NEWS README"
	G2CONF="${G2CONF}
		--without-lasem
		--with-gtk
		$(use_with gnome gconf)"
	filter-flags -ffast-math
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die
}
