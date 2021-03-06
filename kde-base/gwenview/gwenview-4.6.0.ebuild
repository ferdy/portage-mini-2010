# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/gwenview/gwenview-4.6.0.ebuild,v 1.1 2011/01/26 20:28:45 alexxy Exp $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE image viewer"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug kipi semantic-desktop"

# tests hang, last checked for 4.2.96
RESTRICT="test"

DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
	>=media-gfx/exiv2-0.18
	virtual/jpeg
	kipi? ( $(add_kdebase_dep libkipi) )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with kipi)
	)

	if use semantic-desktop; then
		mycmakeargs+=(-DGWENVIEW_SEMANTICINFO_BACKEND=Nepomuk)
	else
		mycmakeargs+=(-DGWENVIEW_SEMANTICINFO_BACKEND=None)
	fi

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "For SVG support, emerge -va kde-base/svgpart"
	echo
}
