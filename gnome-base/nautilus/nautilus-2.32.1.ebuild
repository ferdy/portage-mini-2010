# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-2.32.1.ebuild,v 1.1 2010/11/18 21:45:10 pacho Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit eutils gnome2 virtualx

DESCRIPTION="A file manager for the GNOME desktop"
HOMEPAGE="http://live.gnome.org/Nautilus"

LICENSE="GPL-2 LGPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE="doc gnome +introspection xmp"

RDEPEND=">=dev-libs/glib-2.25.9
	>=gnome-base/gnome-desktop-2.29.91:2
	>=x11-libs/pango-1.1.2
	>=x11-libs/gtk+-2.22:2[introspection?]
	>=dev-libs/libxml2-2.4.7
	>=media-libs/libexif-0.5.12
	>=gnome-base/gconf-2
	dev-libs/libunique
	x11-libs/libXext
	x11-libs/libXrender
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )
	xmp? ( >=media-libs/exempi-2 )"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	sys-devel/gettext
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.40.1
	doc? ( >=dev-util/gtk-doc-1.4 )"
# For eautoreconf
#	gnome-base/gnome-common
#	dev-util/gtk-doc-am"

PDEPEND="gnome? ( >=x11-themes/gnome-icon-theme-1.1.91 )
	>=gnome-base/gvfs-0.1.2"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-update-mimedb
		--disable-packagekit
		$(use_enable introspection)
		$(use_enable xmp)"
	DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS README THANKS TODO"
}

src_prepare() {
	gnome2_src_prepare

	# Remove crazy CFLAGS
	sed 's:-DG.*DISABLE_DEPRECATED::g' -i configure.in configure \
		|| die "sed 1 failed"
}

src_test() {
	addpredict "/root/.gnome2_private"
	unset SESSION_MANAGER
	unset ORBIT_SOCKETDIR
	unset DBUS_SESSION_BUS_ADDRESS
	Xemake check || die "Test phase failed"
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "remove of la files failed"
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog "nautilus can use gstreamer to preview audio files. Just make sure"
	elog "to have the necessary plugins available to play the media type you"
	elog "want to preview"
}
