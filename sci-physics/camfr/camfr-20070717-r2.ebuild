# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/camfr/camfr-20070717-r2.ebuild,v 1.2 2010/06/25 22:37:22 arfrever Exp $

EAPI=2

PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils toolchain-funcs

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="true"

DESCRIPTION="Full vectorial Maxwell solver based on eigenmode expansion"
HOMEPAGE="http://camfr.sourceforge.net/"
SRC_URI="mirror://sourceforge/camfr/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/blitz
	dev-libs/boost[python]
	dev-python/imaging[tk]
	dev-python/matplotlib
	sci-libs/scipy
	virtual/lapack"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/scons-0.98"

RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${P/-/_}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-python.patch
	cp "${FILESDIR}"/machine_cfg.py.gentoo machine_cfg.py || die
	python_copy_sources

	preparation() {
		local libfort
		local lapack_libs=
		local lapack_libdirs=
		# Configure to compile against selected python version
		cat <<-EOF >> machine_cfg.py
			include_dirs = []
			include_dirs.append("$(python_get_includedir)")
			include_dirs.append("$(python_get_sitedir)")
		EOF

		for x in $(pkg-config --libs-only-l lapack); do
			lapack_libs="${lapack_libs}, \"${x#-l}\""
		done
		for x in $(pkg-config --libs-only-L lapack); do
			lapack_libdirs="${lapack_libdirs}, \"${x#-L}\""
		done
		case "$(tc-getF77)" in
			*gfortran) libfort=gfortran ;;
			*g77) libfort=g2c ;;
		esac
		cat <<-EOF >> machine_cfg.py
			library_dirs = [${lapack_libdirs#,}]
			libs = ["boost_python", "${libfort}", "blitz"${lapack_libs}]
		EOF
	}
	python_execute_function -s preparation
	export F77=$(tc-getF77)
}

src_test() {
	testing() {
		# trick to avoid X in testing (bug #229753)
		echo "backend : Agg" > matplotlibrc
		PYTHONPATH=".:visualisation" "$(PYTHON)" testsuite/camfr_test.py
		rm -f matplotlibrc
	}
	python_execute_function -s testing
}

src_install() {
	distutils_src_install
	dodoc docs/camfr.pdf || die "doc install failed"
}
