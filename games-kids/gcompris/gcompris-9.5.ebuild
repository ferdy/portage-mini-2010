# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gcompris/gcompris-9.5.ebuild,v 1.3 2011/01/28 07:47:53 mr_bones_ Exp $

EAPI=2

PYTHON_DEPEND="python? 2:2.6"
PYTHON_USE_WITH_OPT="python"
PYTHON_USE_WITH="sqlite threads"

inherit autotools eutils python versionator games

DESCRIPTION="full featured educational application for children from 2 to 10"
HOMEPAGE="http://gcompris.net/"
SRC_URI="mirror://sourceforge/gcompris/${PN}-$(replace_version_separator 2 -).tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnet python"

RDEPEND="x11-libs/gtk+:2
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-good
	media-plugins/gst-plugins-ogg
	media-plugins/gst-plugins-alsa
	media-plugins/gst-plugins-vorbis
	media-libs/sdl-mixer
	media-libs/libsdl
	dev-libs/libxml2
	dev-libs/popt
	virtual/libintl
	games-board/gnuchess
	dev-db/sqlite:3
	gnet? ( net-libs/gnet:2 )
	python? ( dev-python/pygtk )"
DEPEND="${RDEPEND}
	gnome-base/gnome-common
	dev-perl/XML-Parser
	sys-devel/gettext
	sys-apps/texinfo
	app-text/texi2html
	dev-util/pkgconfig"
RDEPEND="${RDEPEND}
	media-gfx/tuxpaint
	sci-electronics/gnucap"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
	games_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-cursor.patch
	cp /usr/share/gettext/config.rpath .
	eautoreconf
}

src_configure() {
	GNUCHESS="${GAMES_BINDIR}"/gnuchess \
	egamesconf \
		--disable-dependency-tracking \
		--datarootdir="${GAMES_DATADIR}" \
		--datadir="${GAMES_DATADIR}" \
		--localedir=/usr/share/locale \
		--infodir=/usr/share/info \
		$(use_with python python "$(PYTHON -a)") \
		$(use_enable gnet) \
		--enable-sqlite \
		--enable-py-build-only
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	find "${D}" -name '*.la' -exec rm -f '{}' +
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	prepgamesdirs
}
