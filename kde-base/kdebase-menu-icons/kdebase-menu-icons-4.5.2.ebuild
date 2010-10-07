# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-menu-icons/kdebase-menu-icons-4.5.2.ebuild,v 1.1 2010/10/06 09:17:27 alexxy Exp $

EAPI="3"

KMNAME="kdebase-runtime"
KMMODULE="menu"
inherit kde4-meta

DESCRIPTION="KDE menu icons"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

add_blocker kde-menu-icons