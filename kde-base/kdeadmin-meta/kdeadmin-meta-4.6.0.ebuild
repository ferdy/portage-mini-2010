# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin-meta/kdeadmin-meta-4.6.0.ebuild,v 1.1 2011/01/26 20:28:49 alexxy Exp $

EAPI="3"
inherit kde4-functions

DESCRIPTION="KDE administration tools - merge this to pull in all kdeadmin-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.6"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="aqua cups kdeprefix"

RDEPEND="
	$(add_kdebase_dep kcron)
	$(add_kdebase_dep ksystemlog)
	$(add_kdebase_dep kuser)
	cups? ( $(add_kdebase_dep system-config-printer-kde) )
	$(block_other_slots)
"
