# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-testbrowser/zope-testbrowser-3.11.1.ebuild,v 1.1 2011/01/28 23:57:33 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Programmable browser for functional black-box tests"
HOMEPAGE="http://pypi.python.org/pypi/zope.testbrowser"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-python/mechanize-0.2.0
	dev-python/pytz
	>=net-zope/zope-app-testing-3.8.1
	net-zope/zope-interface
	net-zope/zope-schema"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN/-//}"
