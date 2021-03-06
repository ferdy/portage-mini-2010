# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/boto/boto-1.9b.ebuild,v 1.7 2011/01/04 22:00:44 xmw Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

DESCRIPTION="Amazon Web Services API"
HOMEPAGE="http://code.google.com/p/boto/ http://pypi.python.org/pypi/boto"
SRC_URI="http://boto.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86 ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
