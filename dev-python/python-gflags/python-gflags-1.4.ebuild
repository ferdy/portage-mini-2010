# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-gflags/python-gflags-1.4.ebuild,v 1.2 2010/11/14 21:30:04 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Google's Python argument parsing library."
HOMEPAGE="http://code.google.com/p/python-gflags/"
SRC_URI="http://python-gflags.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

PYTHON_MODNAME="gflags.py"

src_prepare() {
	distutils_src_prepare
	sed -e 's/data_files=\[("bin", \["gflags2man.py"\])\]/scripts=\["gflags2man.py"\]/' -i setup.py
}
