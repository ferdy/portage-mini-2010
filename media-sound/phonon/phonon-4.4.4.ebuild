# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/phonon/phonon-4.4.4.ebuild,v 1.1 2011/01/23 05:21:17 reavertm Exp $

EAPI="3"

inherit cmake-utils

DESCRIPTION="KDE multimedia API"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon"
SRC_URI="mirror://kde/stable/phonon/${PV}/src/${P}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug gstreamer pulseaudio +vlc xine"

COMMON_DEPEND="
	>=x11-libs/qt-core-4.6.0:4
	>=x11-libs/qt-dbus-4.6.0:4
	>=x11-libs/qt-gui-4.6.0:4
	pulseaudio? (
		dev-libs/glib:2
		>=media-sound/pulseaudio-0.9.21[glib]
	)
"
# directshow? ( media-sound/phonon-directshow )
# mmf? ( media-sound/phonon-mmf )
# mplayer? ( media-sound/phonon-mplayer )
# quicktime? ( media-sound/phonon-quicktime )
# waveout? ( media-sound/phonon-waveout )
PDEPEND="
	gstreamer? ( media-sound/phonon-gstreamer )
	vlc? ( >=media-sound/phonon-vlc-0.3.2 )
	xine? ( >=media-sound/phonon-xine-0.4.4 )
"
RDEPEND="${COMMON_DEPEND}
	!kde-base/phonon-xine
	!x11-libs/qt-phonon:4
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/automoc-0.9.87
	dev-util/pkgconfig
"

pkg_setup() {
	if use !gstreamer && use !vlc && use !xine; then
		ewarn "You must at least select one backend for phonon to be usuable"
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with pulseaudio GLIB2)
		$(cmake-utils_use_with pulseaudio PulseAudio)
	)
	cmake-utils_src_configure
}
