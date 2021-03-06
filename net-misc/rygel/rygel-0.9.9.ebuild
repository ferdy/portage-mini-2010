# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rygel/rygel-0.9.9.ebuild,v 1.1 2011/02/22 22:05:42 eva Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Rygel is an open source UPnP/DLNA MediaServer"
HOMEPAGE="http://live.gnome.org/Rygel"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X nls +sqlite tracker transcode"

# The deps for tracker? and transcode? are just the earliest available
# version at the time of writing this ebuild
RDEPEND="
	>=dev-libs/glib-2.26:2
	>=dev-libs/libgee-0.5.2
	>=media-libs/gupnp-dlna-0.5
	>=media-libs/gstreamer-0.10.23
	>=media-libs/gst-plugins-base-0.10.28
	>=net-libs/gssdp-0.9.2
	>=net-libs/gupnp-0.13.4
	>=net-libs/gupnp-av-0.7
	>=net-libs/libsoup-2.26:2.4
	>=sys-libs/e2fsprogs-libs-1.41.3
	sqlite? ( >=dev-db/sqlite-3.5:3 )
	tracker? ( >=app-misc/tracker-0.8.17 )
	transcode? (
		>=media-libs/gst-plugins-bad-0.10.14
		>=media-plugins/gst-plugins-twolame-0.10.12
		>=media-plugins/gst-plugins-ffmpeg-0.10.5
	)
	X? ( >=x11-libs/gtk+-2.90.3:3 )
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	>=dev-util/intltool-0.40
"
# Maintainer only
#	>=dev-lang/vala-0.11.6
#	>=net-libs/gupnp-vala-0.7.5
#   dev-libs/libxslt

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		--enable-gst-launch-plugin
		$(use_enable nls)
		$(use_enable sqlite media-export-plugin)
		$(use_enable tracker tracker-plugin)
		$(use_with X ui)"
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die
}
