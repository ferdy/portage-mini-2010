# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/imdbpy/imdbpy-4.6.ebuild,v 1.4 2010/12/26 14:47:39 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

MY_PN="IMDbPY"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python package to access the IMDb movie database"
HOMEPAGE="http://imdbpy.sourceforge.net/ http://pypi.python.org/pypi/IMDbPY"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/${MY_PN}-${PV}"

PYTHON_MODNAME="imdb"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-data_location.patch"
}

src_install() {
	distutils_src_install
	dodoc docs/*
}
