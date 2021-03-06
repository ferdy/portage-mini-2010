# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-mplayer/gnome-mplayer-0.9.9.2.ebuild,v 1.6 2010/07/19 22:10:51 jer Exp $

EAPI=2
GCONF_DEBUG=no
inherit gnome2

DESCRIPTION="A GTK+ interface to MPlayer"
HOMEPAGE="http://code.google.com/p/gnome-mplayer/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE="alsa gnome ipod libnotify musicbrainz pulseaudio"

RDEPEND=">=dev-libs/glib-2.14:2
	>=x11-libs/gtk+-2.12:2
	>=dev-libs/dbus-glib-0.70
	>=media-video/mplayer-1.0_rc4_p20091026[ass]
	alsa? ( media-libs/alsa-lib )
	gnome? ( gnome-base/gconf:2
		gnome-base/gvfs
		gnome-base/nautilus )
	ipod? ( >=media-libs/libgpod-0.7 )
	libnotify? ( x11-libs/libnotify )
	musicbrainz? ( net-misc/curl
		>=media-libs/musicbrainz-3 )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.14 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	DOCS="ChangeLog README DOCS/keyboard_shortcuts.txt"
	G2CONF="--disable-dependency-tracking
		$(use_enable gnome schemas-install)
		$(use_enable gnome nautilus)
		--enable-panscan
		--with-gio
		$(use_with gnome gconf)
		$(use_with alsa)
		$(use_with libnotify)
		$(use_with ipod libgpod)
		$(use_with musicbrainz libmusicbrainz3)
		$(use_with pulseaudio flat-volume)
		--without-gpm-new-method
		--without-gpm-old-method"
}

src_install() {
	gnome2_src_install
	rm -rf "${D}"/usr/share/doc/${PN}
	rmdir -p "${D}"/var/lib
}
