# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/eiskaltdcpp/eiskaltdcpp-2.1.1.ebuild,v 1.4 2011/01/19 13:02:20 scarabeus Exp $

EAPI="3"

LANGS="be bg en es fr hu pl ru sr uk"
inherit qt4-r2 cmake-utils

DESCRIPTION="Qt4 based client for DirectConnect and ADC protocols, based on DC++ library"
HOMEPAGE="http://eiskaltdc.googlecode.com/"
SRC_URI="http://${PN/pp/}.googlecode.com/files/${P}.tar.xz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dbus +emoticons examples -gnome -gtk -javascript libnotify lua +qt4 pcre sounds spell upnp"

RDEPEND="
	app-arch/bzip2
	sys-libs/zlib
	>=dev-libs/openssl-0.9.8
	virtual/libiconv
	sys-devel/gettext
	lua? ( >=dev-lang/lua-5.1 )
	upnp? ( net-libs/miniupnpc )
	gtk? (
		x11-libs/pango
		>=x11-libs/gtk+-2.10:2
		>=dev-libs/glib-2.10:2
		>=gnome-base/libglade-2.4:2.0
		libnotify? ( >=x11-libs/libnotify-0.4.1 )
		gnome? ( gnome-base/libgnome )
	)
	qt4? (
		>=x11-libs/qt-gui-4.4.0:4[dbus?]
		javascript? (
			x11-libs/qt-script
			x11-libs/qtscriptgenerator
		)
		spell? ( app-text/aspell )
	)
	pcre? ( >=dev-libs/libpcre-4.2 )
"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	>=dev-libs/boost-1.34.1
	dev-util/pkgconfig
"
DOCS="AUTHORS ChangeLog.txt"

src_configure() {
	# linguas
	local langs x
	for x in ${LANGS}; do
		use linguas_${x} && langs+=" ${x}"
	done

	local mycmakeargs=(
		-DLIB_INSTALL_DIR="$(get_libdir)"
		"$(cmake-utils_use lua LUA_SCRIPT)"
		"$(cmake-utils_use dbus DBUS_NOTIFY)"
		"$(cmake-utils_use javascript USE_JS)"
		"$(cmake-utils_use spell USE_ASPELL)"
		"$(cmake-utils_use qt4 USE_QT)"
		"$(cmake-utils_use upnp USE_MINIUPNP)"
		-DLOCAL_MINIUPNP="0"
		"$(cmake-utils_use gtk USE_GTK)"
		"$(cmake-utils_use gnome USE_LIBGNOME2)"
		"$(cmake-utils_use libnotify USE_LIBNOTIFY)"
		"$(cmake-utils_use emoticons WITH_EMOTICONS)"
		"$(cmake-utils_use examples WITH_EXAMPLES)"
		"$(cmake-utils_use lua WITH_LUASCRIPTS)"
		"$(cmake-utils_use pcre PERL_REGEX)"
		"$(cmake-utils_use sounds WITH_SOUNDS)"
		-Dlinguas="${langs}"
	)
	cmake-utils_src_configure
}
