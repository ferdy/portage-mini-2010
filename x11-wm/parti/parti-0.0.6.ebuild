# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/parti/parti-0.0.6.ebuild,v 1.3 2010/10/07 09:46:17 phajdan.jr Exp $

EAPI=2

PYTHON_DEPEND=2

inherit distutils eutils python

DESCRIPTION="X Persistent Remote Apps (xpra) and Partitioning WM (parti) based on wimpiggy"
HOMEPAGE="http://partiwm.googlecode.com/"
MY_P="${PN}-all-${PV}"
SRC_URI="http://${PN}wm.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
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

S=${WORKDIR}/${MY_P}

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	# upstream changeset 620a831d81, solved deprecation warnings on module sets
	epatch "${FILESDIR}"/${P}-python-2.6-sets-deprecation.patch

	# upstream changeset fedd8b2841, adds missing import sys
	epatch "${FILESDIR}"/${P}-python-import.patch
}
