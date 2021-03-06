# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pida/pida-0.6.2.ebuild,v 1.2 2010/12/13 16:58:50 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
# json module required.
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

inherit distutils eutils

DESCRIPTION="Gtk and/or Vim-based Python Integrated Development Application"
HOMEPAGE="http://pida.co.uk/ http://pypi.python.org/pypi/pida"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="gnome"

RDEPEND="|| ( dev-lang/python:2.7 dev-python/argparse )
	>=app-editors/gvim-6.3
	>=dev-python/anyvc-0.3.2
	>=dev-python/bpython-0.9.7
	>=dev-python/pygtk-2.8
	>dev-python/pygtkhelpers-0.4.1
	gnome? ( >=x11-libs/vte-0.11.11-r2[python] )"
DEPEND="${RDEPEND}
	dev-python/setuptools
	dev-util/pkgconfig"

src_prepare() {
	distutils_src_prepare

	# Don't require argparse with Python 2.7.
	sed -e "/argparse/d" -i setup.py || die "sed failed"

	epatch "${FILESDIR}/${PN}-0.6.1-fix_implicit_declaration.patch"
	emake -C contrib/moo moo-pygtk.c
}

src_install() {
	distutils_src_install
	make_desktop_entry pida Pida pida/resources/pixmaps/pida-icon.png Development
}
