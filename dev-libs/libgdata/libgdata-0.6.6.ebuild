# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgdata/libgdata-0.6.6.ebuild,v 1.2 2011/01/23 17:35:17 eva Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit eutils gnome2

DESCRIPTION="GLib-based library for accessing online service APIs using the GData protocol"
HOMEPAGE="http://live.gnome.org/libgdata"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc gnome +introspection"

# gtk+ is needed for gdk
RDEPEND=">=dev-libs/glib-2.19:2
	>=x11-libs/gtk+-2:2
	>=dev-libs/libxml2-2
	>=net-libs/libsoup-2.26.1:2.4
	gnome? ( >=net-libs/libsoup-gnome-2.26.1:2.4 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.7 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	doc? ( >=dev-util/gtk-doc-1 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog HACKING NEWS README"
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable gnome)
		$(use_enable introspection)"
}

src_prepare() {
	gnome2_src_prepare

	# Disable tests requiring network access, bug #307725
	sed -e '/^TEST_PROGS = / s:\(.*\):TEST_PROGS = general perf\nOLD_\1:' \
		-i gdata/tests/Makefile.in || die "network test disable failed"
}

src_test() {
	unset ORBIT_SOCKETDIR
	unset DBUS_SESSION_BUS_ADDRESS
	dbus-launch emake check || die "emake check failed"
}

pkg_preinst() {
	gnome2_pkg_preinst
	preserve_old_lib /usr/$(get_libdir)/libgdata.so.6
}

pkg_postinst() {
	gnome2_pkg_postinst
	preserve_old_lib_notify /usr/$(get_libdir)/libgdata.so.6
}
