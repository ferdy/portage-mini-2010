# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gdata/gdata-2.0.13.ebuild,v 1.9 2011/02/08 22:20:44 xarthisius Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P="gdata-${PV}"

DESCRIPTION="Python client library for Google data APIs"
HOMEPAGE="http://code.google.com/p/gdata-python-client/ http://pypi.python.org/pypi/gdata"
SRC_URI="http://gdata-python-client.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="examples"

DEPEND="|| ( dev-lang/python:2.7[xml] dev-lang/python:2.6[xml] dev-lang/python:2.5[xml] dev-python/elementtree )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="atom gdata"

src_prepare() {
	distutils_src_prepare

	# http://code.google.com/p/gdata-python-client/issues/detail?id=474
	# http://code.google.com/p/gdata-python-client/source/detail?r=0ead99676f39b214db3584ed418efb214f45c70d
	sed -e "/http:\/\/docs\.google\.com\/feeds\/documents\/private\/full\//s/http/https/" -i tests/gdata_tests/docs_test.py || die "sed failed"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" tests/run_data_tests.py -v || return 1

		# run_service_tests.py requires interaction (and a valid Google account), so skip it.
		# PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" tests/run_service_tests.py -v || return 1
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r samples || die "Installation of examples failed"
	fi
}
