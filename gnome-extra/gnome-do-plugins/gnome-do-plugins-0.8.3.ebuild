# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-do-plugins/gnome-do-plugins-0.8.3.ebuild,v 1.1 2011/02/09 18:55:03 graaff Exp $

EAPI=2

inherit eutils autotools gnome2 mono versionator

MY_PN="do-plugins"
PVC=$(get_version_component_range 1-3)

DESCRIPTION="Plugins to put the Do in Gnome Do"
HOMEPAGE="http://do.davebsd.com/"
SRC_URI="https://launchpad.net/${MY_PN}/trunk/${PVC}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="banshee"

RDEPEND=">=gnome-extra/gnome-do-${PV}
		dev-dotnet/wnck-sharp
		banshee? ( >=media-sound/banshee-1.4.2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	# The build system doesn't properly disable this plugin, so remove
	# it the hard way.
	sed -i -e '/Empathy/d' Makefile.am || die

	eautomake
}

src_configure() {
	econf --enable-debug=no --enable-release=yes \
		$(use banshee) \
		--disable-empathy \
		--disable-flickr || die "configure failed"
}

src_compile()
{
	# The make system is unfortunately broken for parallel builds and
	# upstream indicated on IRC that they have no intention to fix
	# that.
	emake -j1 || die "make failed"
}
