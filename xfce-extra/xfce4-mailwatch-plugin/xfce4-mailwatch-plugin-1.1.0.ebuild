# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mailwatch-plugin/xfce4-mailwatch-plugin-1.1.0.ebuild,v 1.4 2011/02/04 17:57:00 ssuominen Exp $

EAPI=3
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Mail notification panel plugin"
HOMEPAGE="http://spuriousinterrupt.org/projects/mailwatch"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug ipv6 ssl"

RDEPEND=">=xfce-base/libxfce4util-4.2
	>=xfce-base/libxfcegui4-4.2
	>=xfce-base/xfce4-panel-4.3.20
	ssl? ( >=net-libs/gnutls-1.2 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	PATCHES=(
		"${FILESDIR}"/${P}-no-ssl.patch
		"${FILESDIR}"/${P}-link_to_libxfcegui4.patch
		)

	XFCONF=(
		--disable-dependency-tracking
		$(use_enable ssl)
		$(use_enable ipv6)
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog NEWS README TODO"
}
