# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xkb-plugin/xfce4-xkb-plugin-0.5.3.3-r1.ebuild,v 1.14 2011/01/19 20:04:39 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="XKB layout switching panel plugin"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-xkb-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.5/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/xfce4-panel-4.3.20
	>=xfce-base/libxfce4util-4.3.90.2
	>=xfce-base/libxfcegui4-4.3.90.2
	>=x11-libs/libxklavier-5
	x11-libs/libwnck"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	x11-proto/kbproto
	>=gnome-base/librsvg-2.18"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-libxklavier-5.patch )

	XFCONF=(
		--disable-dependency-tracking
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog README"
}
