# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/qhull/qhull-2010.1-r2.ebuild,v 1.5 2010/12/29 01:28:40 ranger Exp $

EAPI=3

inherit cmake-utils flag-o-matic

MY_P="${PN}${PV}"
DESCRIPTION="Geometry library"
HOMEPAGE="http://www.qhull.org"
SRC_URI="${HOMEPAGE}/download/${P}-src.tgz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="alpha amd64 ~hppa ~ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="doc static-libs"

DOCS="Announce.txt File_id.diz README.txt REGISTER.txt"
PATCHES=( "${FILESDIR}/${P}-cmake-install.patch" "${FILESDIR}/${P}-overflows.patch" )

src_configure() {
	append-flags -fno-strict-aliasing
	mycmakeargs="
		-DLIB_INSTALL_DIR=${EPREFIX}/usr/$(get_libdir)
		-DDOC_INSTALL_DIR=${EPREFIX}/usr/share/doc/${PF}
		$(cmake-utils_use_with static-libs STATIC_LIBS)
		$(cmake-utils_use_with doc DOCS)"
	cmake-utils_src_configure
}
