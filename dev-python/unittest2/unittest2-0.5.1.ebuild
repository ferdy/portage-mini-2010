# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/unittest2/unittest2-0.5.1.ebuild,v 1.11 2011/01/07 17:47:51 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="The new features in unittest for Python 2.7 backported to Python 2.4+."
HOMEPAGE="http://pypi.python.org/pypi/unittest2 http://pypi.python.org/pypi/unittest2py3k http://code.google.com/p/unittest-ext/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	mirror://pypi/${PN:0:1}/${PN}py3k/${PN}py3k-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ~ppc64 ~s390 ~sparc x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

DOCS="README.txt"

src_prepare() {
	preparation() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			cp -pr "${WORKDIR}/${PN}py3k-${PV}" "${S}-${PYTHON_ABI}" || return 1
		else
			cp -pr "${S}" "${S}-${PYTHON_ABI}" || return 1
		fi

		# Disable versioning of unit2 script to avoid collision with versioning performed by distutils_src_install().
		sed -e "/'%s = unittest2:main_' % SCRIPT2,/d" -i "${S}-${PYTHON_ABI}/setup.py" || return 1
	}
	python_execute_function -q preparation
}

src_test() {
	testing() {
		./unit2 discover
	}
	python_execute_function -s testing
}
