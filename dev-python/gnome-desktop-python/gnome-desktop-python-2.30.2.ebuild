# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-desktop-python/gnome-desktop-python-2.30.2.ebuild,v 1.8 2010/11/02 02:17:27 ford_prefect Exp $

EAPI=1

GCONF_DEBUG="no"
G_PY_PN="gnome-python-desktop"
G_PY_BINDINGS="gnomedesktop"

inherit gnome-python-common

DESCRIPTION="Python bindings for some GNOME desktop libraries"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~ia64 ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=gnome-base/gnome-desktop-2.10.0:2
	>=dev-python/gnome-vfs-python-2.22
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"
