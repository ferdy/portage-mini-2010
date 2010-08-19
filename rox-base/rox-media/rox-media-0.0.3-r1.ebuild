# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-media/rox-media-0.0.3-r1.ebuild,v 1.1 2010/08/11 14:52:35 lack Exp $

EAPI=3
inherit rox eutils

DESCRIPTION="Manage removable drives for ROX and other lightweight desktops"
HOMEPAGE="http://rox.sourceforge.net"
SRC_URI="mirror://gentoo/Media-0.0.3.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	gnome-base/gconf:2
	sys-apps/gnome-disk-utility
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/scons"

APPNAME="Media"
WRAPPERNAME="rox-media"
APPCATEGORY="System"

src_prepare() {
	cd "${APPNAME}"
	epatch "${FILESDIR}/${P}-Respect-env.patch"
}

# Override rox_src_compile for this non-standard build environment
src_compile() {
	cd "${APPNAME}"
	scons

	# Cleanup build products
	rm -rf .sconf_temp .sconsign.dblite src/*.o config.log

	# Cleanup sources
	rm -rf Makefile SConstruct templates genclass geninterface \
		test.c src/*.[ch] src/Makefile src/SConscript
}