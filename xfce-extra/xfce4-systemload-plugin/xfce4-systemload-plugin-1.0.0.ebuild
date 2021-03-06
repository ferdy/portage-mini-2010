# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-systemload-plugin/xfce4-systemload-plugin-1.0.0.ebuild,v 1.1 2010/12/11 11:35:58 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="System load plug-in for Xfce panel"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-systemload-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.0/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/xfce4-panel-4.3.99.1
	>=xfce-base/libxfcegui4-4.3.99.1
	>=xfce-base/libxfce4util-4.3.99.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(xfconf_use_debug)
		)
	DOCS="AUTHORS ChangeLog NEWS README"
}
