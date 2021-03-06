# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/notify-python/notify-python-0.1.1-r1.ebuild,v 1.18 2011/01/29 16:20:21 ssuominen Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit eutils python

DESCRIPTION="Python bindings for libnotify"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 ~sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.4.0
	>=x11-libs/libnotify-0.4.3"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	has_version ">=x11-libs/libnotify-0.7" && epatch "${FILESDIR}"/${P}-libnotify-0.7.patch

	# Disable byte-compilation.
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile

	# Remove the old pynotify.c to ensure it's properly regenerated #212128.
	rm -f src/pynotify.c

	python_src_prepare
}

src_install() {
	python_src_install
	python_clean_installation_image
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	python_mod_optimize gtk-2.0/pynotify
}

pkg_postrm() {
	python_mod_cleanup gtk-2.0/pynotify
}
