# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apsw/apsw-3.7.4.1.ebuild,v 1.1 2010/12/19 13:03:02 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils eutils versionator

MY_PV="$(replace_version_separator 3 -r)"

DESCRIPTION="APSW - Another Python SQLite Wrapper"
HOMEPAGE="http://code.google.com/p/apsw/"
SRC_URI="http://apsw.googlecode.com/files/${PN}-${MY_PV}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-db/sqlite-$(get_version_component_range 1-3)[extensions]"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${PN}-${MY_PV}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-3.6.20.1-fix_tests.patch"
}

src_compile() {
	distutils_src_compile --enable=load_extension
}

src_test() {
	echo "$(PYTHON -f)" setup.py build_test_extension
	"$(PYTHON -f)" setup.py build_test_extension || die "Building of test loadable extension failed"

	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" tests.py -v
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	dodoc doc/_sources/* || die "dodoc failed"
	dohtml -r doc/* || die "dohtml failed"
}
