# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kget/kget-4.4.5.ebuild,v 1.5 2010/08/09 17:34:55 scarabeus Exp $

EAPI="3"

KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="An advanced download manager for KDE"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook +plasma semantic-desktop sqlite"

RDEPEND="
	app-crypt/qca:2
	dev-libs/gmp
	dev-libs/libpcre
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep libkonq)
	$(add_kdebase_dep libkworkspace)
	sqlite? ( dev-db/sqlite:3 )
"
DEPEND="${RDEPEND}
	dev-libs/boost
"

src_configure() {
	mycmakeargs=(
		-DENABLE_EMBEDDED_TORRENT_SUPPORT=ON
		$(cmake-utils_use_with plasma)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with sqlite)
	)

	kde4-meta_src_configure
}
