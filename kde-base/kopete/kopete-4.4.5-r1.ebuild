# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-4.4.5-r1.ebuild,v 1.5 2010/08/09 17:34:33 scarabeus Exp $

EAPI="3"

KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="KDE multi-protocol IM client"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook ssl v4l2"

# tests hang, last checked for 4.2.96
RESTRICT=test

# Available plugins
#
#	addbookmarks: NO DEPS
#	alias: NO DEPS (disabled upstream)
#	autoreplace: NO DEPS
#	contactnotes: NO DEPS
#	highlight: NO DEPS
#	history: NO DEPS
#	latex: virtual/latex as RDEPEND
#	nowlistening: NO DEPS
#	otr: libotr
#	pipes: NO DEPS
#	privacy: NO DEPS
#	statistics: dev-db/sqlite:3
#	texteffect: NO DEPS
#	translator: NO DEPS
#	urlpicpreview: NO DEPS
#	webpresence: libxml2 libxslt
# NOTE: By default we enable all plugins that don't have any dependencies
PLUGINS="+addbookmarks +autoreplace +contactnotes +highlight +history latex
+nowlistening otr +pipes +privacy +statistics +texteffect +translator
+urlpicpreview webpresence"

# Available protocols
#
#	gadu: net-libs/libgadu @since 4.3
#	groupwise: app-crypt/qca:2
#	irc: NO DEPS, probably will fail so inform user about it
#	jabber: net-dns/libidn app-crypt/qca:2 ENABLED BY DEFAULT NETWORK
#	jingle: media-libs/speex net-libs/ortp DISABLED BY UPSTREAM
#	meanwhile: net-libs/meanwhile
#	msn: libmsn == this is wlm plugin, we disable msn one
#	oscar: NO DEPS
#	qq: NO DEPS
#   telepathy: net-libs/decibel
#   testbed: NO DEPS
#	winpopup: NO DEPS (we're adding samba as RDEPEND so it works)
#	yahoo: NO DEPS
#	zeroconf (bonjour): NO DEPS
PROTOCOLS="gadu groupwise +jabber jingle meanwhile msn oscar qq skype
sms testbed winpopup yahoo zeroconf"

# disabled protocols
#   telepathy: net-libs/decibel
#   irc: NO DEPS

IUSE="${IUSE} ${PLUGINS} ${PROTOCOLS}"

COMMONDEPEND="
	dev-libs/libpcre
	$(add_kdebase_dep kdepimlibs)
	media-libs/qimageblitz
	>=x11-libs/qt-gui-4.4.0:4[mng]
	!aqua? ( x11-libs/libXScrnSaver )
	gadu? ( >=net-libs/libgadu-1.8.0[threads] )
	groupwise? ( app-crypt/qca:2 )
	jabber? (
		app-crypt/qca:2
		net-dns/libidn
	)
	jingle? (
		>=media-libs/mediastreamer-2.3.0
		media-libs/speex
		net-libs/ortp
	)
	meanwhile? ( net-libs/meanwhile )
	msn? ( >=net-libs/libmsn-4.1 )
	otr? ( >=net-libs/libotr-3.2.0 )
	statistics? ( dev-db/sqlite:3 )
	webpresence? ( dev-libs/libxml2 dev-libs/libxslt )
	v4l2? ( media-libs/libv4l )
"
RDEPEND="${COMMONDEPEND}
	latex? (
		media-gfx/imagemagick
		virtual/latex-base
	)
	sms? ( app-mobilephone/smssend )
	ssl? ( app-crypt/qca-ossl )
	winpopup? ( net-fs/samba )
"
#	telepathy? ( net-libs/decibel )"
DEPEND="${COMMONDEPEND}
	!aqua? ( x11-proto/scrnsaverproto )
"

PATCHES=( "${FILESDIR}/${P}-openssl-1.patch" )

src_prepare() {
	sed -e "s:lib/mozilla:$(get_libdir)/mozilla:" \
		-i kopete/protocols/skype/skypebuttons/CMakeLists.txt || die "sed failed"
	sed -e '/set (LIBV4L2_REQUIRED TRUE)/s/TRUE/FALSE/' \
		-i kopete/CMakeLists.txt || die 'failed to make v4l2 optional'

	kde4-meta_src_prepare
}

src_configure() {
	local x x2
	# Handle common stuff
	mycmakeargs=(
		$(cmake-utils_use_with jingle GOOGLETALK)
		$(cmake-utils_use_with jingle LiboRTP)
		$(cmake-utils_use_with jingle Mediastreamer)
		$(cmake-utils_use_with jingle Speex)
		$(cmake-utils_use_with v4l2 LibV4L2)
	)
	# enable protocols
	for x in ${PROTOCOLS}; do
		case ${x/+/} in
			msn) x2=wlm ;;
			zeroconf) x2=bonjour ;;
			*) x2='' ;;
		esac
		mycmakeargs+=($(cmake-utils_use_with ${x/+/} ${x2}))
	done

	# enable plugins
	for x in ${PLUGINS}; do
		mycmakeargs+=($(cmake-utils_use_with ${x/+/}))
	done

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	#if use telepathy; then
	#	elog "To use kopete telepathy plugins, you need to start gabble first:"
	#	elog "GABBLE_PERSIST=1 telepathy-gabble &"
	#	elog "export TELEPATHY_DATA_PATH='${EPREFIX}/usr/share/telepathy/managers/'"
	#fi

	if ! use ssl; then
		if use jabber || use msn; then # || use irc; then
			echo
			#elog "In order to use ssl in jabber, msn and irc you'll need to"
			elog "In order to use ssl in jabber and msn you'll need to"
			elog "install app-crypt/qca-ossl package."
			echo
		fi
	fi
}
