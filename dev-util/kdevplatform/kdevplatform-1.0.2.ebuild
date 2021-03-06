# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevplatform/kdevplatform-1.0.2.ebuild,v 1.4 2011/01/30 12:53:01 tampakrap Exp $

EAPI=3

# Bug 276208
RESTRICT="test"

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="ca ca@valencia da en_GB es et fi fr gl it nds nl pt pt_BR sl sv tr uk zh_CN zh_TW"
fi

KMNAME="kdevelop"
inherit kde4-base

DESCRIPTION="KDE development support libraries and apps"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
# Moved to playground for now
# bazaar git kompare mercurial
IUSE="cvs debug subversion"

# Moved to playground for now
# bazaar? ( dev-vcs/bzr )
# kompare? ( >=kde-base/kompare-${KDE_MINIMAL} )
# mercurial? ( dev-vcs/mercurial )
# git? ( dev-vcs/git )
# block - some plugins moved to kdevplatform from kdevelop
DEPEND="
	dev-libs/boost
	subversion? ( >=dev-vcs/subversion-1.3 )
"
RDEPEND="${DEPEND}
	!<dev-util/kdevelop-${KDEVELOP_VERSION}
	$(add_kdebase_dep konsole)
	cvs? ( dev-vcs/cvs )
"

src_prepare() {
	kde4-base_src_prepare

	# FindKDevPlatform.cmake is installed by kdelibs
	sed -i \
		-e '/cmakeFiles/s/^/#DONOTINSTALL/' \
		cmake/modules/CMakeLists.txt || die
}

# Moved to playground for now
# $(cmake-utils_use_build bazaar)
# $(cmake-utils_use_build git)
# $(cmake-utils_use_with kompare)
# $(cmake-utils_use_build mercurial)
src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build cvs)
		$(cmake-utils_use_build subversion)
		$(cmake-utils_use_with subversion SubversionLibrary)
	)

	kde4-base_src_configure
}
