# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-media-python/gnome-media-python-2.32.0.ebuild,v 1.1 2010/11/05 23:13:19 pacho Exp $

EAPI="3"
GCONF_DEBUG="no"
G_PY_PN="gnome-python-desktop"
G_PY_BINDINGS="mediaprofiles"

inherit gnome-python-common

DESCRIPTION="Python bindings for GNOME media profiles"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=gnome-extra/gnome-media-2.10.0
	>=gnome-base/gconf-2.10.0
	>=dev-python/gconf-python-2.25.90
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"

EXAMPLES="examples/mediaprofiles/*"
