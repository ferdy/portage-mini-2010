# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/parti/parti-0.0.6_p456.ebuild,v 1.2 2010/11/25 16:55:42 xmw Exp $

EAPI=2

PYTHON_DEPEND=2

inherit distutils eutils python

DESCRIPTION="X Persistent Remote Apps (xpra) and Partitioning WM (parti) based on wimpiggy"
HOMEPAGE="http://partiwm.googlecode.com/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="dev-python/pygtk
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXtst"

RDEPEND="${COMMON_RDEPEND}
	dev-python/ipython
	x11-apps/xmodmap"
DEPEND="${COMMON_RDEPEND}
	dev-python/pyrex
	dev-util/pkgconfig"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	$(PYTHON -2 -a) make_constants_pxi.py wimpiggy/lowlevel/constants.txt wimpiggy/lowlevel/constants.pxi || die
}
