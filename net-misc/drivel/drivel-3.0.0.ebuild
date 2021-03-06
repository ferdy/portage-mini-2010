# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/drivel/drivel-3.0.0.ebuild,v 1.5 2011/02/16 09:49:58 hwoarang Exp $

EAPI="2"

inherit autotools eutils gnome2

DESCRIPTION="Drivel is a desktop blogger with support for LiveJournal, Blogger,
MoveableType, Wordpress and more."
HOMEPAGE="http://drivel.sourceforge.net/"
SRC_URI="mirror://sourceforge/drivel/${P}.tar.bz2"
LICENSE="GPL-2"

IUSE="dbus spell"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"

RDEPEND=">=dev-libs/glib-2.16.6
	>=x11-libs/gtk+-2.16.5
	>=gnome-base/gconf-2
	>=gnome-base/gnome-vfs-2.6
	>=x11-libs/gtksourceview-2.2.2
	>=net-libs/libsoup-2.4.1
	>=dev-libs/libxml2-2.4.0
	spell? ( >=app-text/gtkspell-2.0.10 )
	dbus? ( >=dev-libs/dbus-glib-0.78 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/intltool-0.21
	>=app-text/scrollkeeper-0.3.5"
DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_with spell gtkspell)
		$(use_with dbus)
		--disable-mime-update
		--disable-desktop-update
		--disable-error-on-warning
		--disable-compile-warnings
		--localstatedir=${D}/var"
}
src_prepare() {
	epatch "${FILESDIR}/${P}-compile-warnings.patch"

	intltoolize --automake --copy --force || die "intltoolize failed"
	eautoreconf
}
