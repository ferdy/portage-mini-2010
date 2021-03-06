# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/clucene/clucene-9999.ebuild,v 1.2 2010/07/22 08:11:59 reavertm Exp $

EAPI="3"

inherit git cmake-utils

DESCRIPTION="High-performance, full-featured text search engine based off of lucene in C++"
HOMEPAGE="http://clucene.sourceforge.net/"
EGIT_REPO_URI="git://${PN}.git.sourceforge.net/gitroot/${PN}/${PN}"

LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
SLOT="1"
KEYWORDS=""
IUSE="debug doc static-libs threads"

RDEPEND=""
DEPEND="
	doc? ( >=app-doc/doxygen-1.4.2 )
"

PATCHES=(
	"${FILESDIR}/${P}-cmake.patch"
)

DOCS=(AUTHORS ChangeLog README README.PACKAGE REQUESTS)

src_unpack() {
	git_src_unpack
}

src_configure() {
	mycmakeargs=(
		-DENABLE_ASCII_MODE=OFF
		-DENABLE_PACKAGING=OFF
		$(cmake-utils_use_enable debug)
		$(cmake-utils_use_enable doc CLDOCS)
		$(cmake-utils_use_build static-libs STATIC_LIBRARIES)
		$(cmake-utils_use_disable threads MULTITHREADING)
	)

	cmake-utils_src_configure
}
