# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/polkit-gnome/polkit-gnome-0.96-r1.ebuild,v 1.7 2011/01/31 16:41:42 eva Exp $

EAPI="2"

inherit autotools eutils gnome2

DESCRIPTION="PolicyKit policies and configurations for the GNOME desktop"
HOMEPAGE="http://hal.freedesktop.org/docs/PolicyKit"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.bz2"

LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="doc examples" #introspection

RDEPEND=">=x11-libs/gtk+-2.17.1:2
	>=gnome-base/gconf-2.8
	>=dev-libs/dbus-glib-0.71
	>=sys-auth/polkit-0.95
	<sys-auth/polkit-0.99"
	# Not ready for tree
	#introspection? ( >=dev-libs/gobject-introspection-0.6.2 )
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.35.0
	>=app-text/scrollkeeper-0.3.14
	gnome-base/gnome-common
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1.3 )"

DOCS="AUTHORS HACKING NEWS TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-introspection
		$(use_enable examples)"
		#$(use_enable introspection)"
}

src_prepare() {
	# polkit-gnome is useful also for LXDE, XFCE, and others
	sed -i \
		-e 's:OnlyShowIn=GNOME:NotShowIn=KDE:' \
		src/polkit-gnome-authentication-agent-1.desktop.in.in || die

	# Fix make check, bug 298345
	epatch "${FILESDIR}/${PN}-0.95-fix-make-check.patch"

	if use doc; then
		# Fix parallel build failure, bug 293247
		epatch "${FILESDIR}/${PN}-0.95-parallel-build-failure.patch"

		gtkdocize || die "gtkdocize failed"
		eautoreconf
	fi
}
