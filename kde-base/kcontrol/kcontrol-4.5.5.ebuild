# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-4.5.5.ebuild,v 1.1 2011/01/10 11:53:24 tampakrap Exp $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Control Center"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdnssd)
	$(add_kdebase_dep khotkeys)
"

add_blocker systemsettings '<4.2.91'
