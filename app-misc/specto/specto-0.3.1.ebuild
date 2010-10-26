# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/specto/specto-0.3.1.ebuild,v 1.1 2010/10/26 17:22:44 xmw Exp $

EAPI=2

PYTHON_DEPEND="2"
PYTHON_MODNAME="spectlib"

inherit distutils eutils

DESCRIPTION="watch configurable events and trigger notifications"
HOMEPAGE="http://specto.sourceforge.net/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="linguas_cs linguas_de linguas_es linguas_fr linguas_it
	linguas_pt_BR linguas_ro linguas_sv linguas_tr"

RDEPEND="dev-python/gconf-python
	dev-python/dbus-python
	dev-python/notify-python
	>=dev-python/pygtk-2.10"

src_prepare() {
	epatch "${FILESDIR}"/${P}-icon-theme.patch

	sed -e "s:share/doc/specto:share/doc/${PF}:" \
		-i setup.py spectlib/util.py || die

	sed -e "/^i18n_languages = /s: = .*: = \"${LINGUAS}\":" \
		-i setup.py || die
}