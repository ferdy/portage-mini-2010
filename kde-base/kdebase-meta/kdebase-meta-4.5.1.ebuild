# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-meta/kdebase-meta-4.5.1.ebuild,v 1.2 2010/09/06 04:51:04 reavertm Exp $

EAPI="3"
inherit kde4-functions

DESCRIPTION="Merge this to pull in all kdebase-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.5"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="aqua kdeprefix"

RDEPEND="
	$(add_kdebase_dep dolphin)
	$(add_kdebase_dep freespacenotifier)
	$(add_kdebase_dep kcheckpass)
	$(add_kdebase_dep kcminit)
	$(add_kdebase_dep kdebase-cursors)
	$(add_kdebase_dep kdebase-runtime-meta)
	$(add_kdebase_dep kdebase-startkde)
	$(add_kdebase_dep kdebase-wallpapers)
	$(add_kdebase_dep kdepasswd)
	$(add_kdebase_dep kdialog)
	$(add_kdebase_dep keditbookmarks)
	$(add_kdebase_dep kephal)
	$(add_kdebase_dep kfind)
	$(add_kdebase_dep kfmclient)
	$(add_kdebase_dep khotkeys)
	$(add_kdebase_dep kinfocenter)
	$(add_kdebase_dep klipper)
	$(add_kdebase_dep kmenuedit)
	$(add_kdebase_dep konqueror)
	$(add_kdebase_dep konsole)
	$(add_kdebase_dep kscreensaver)
	$(add_kdebase_dep ksmserver)
	$(add_kdebase_dep ksplash)
	$(add_kdebase_dep kstartupconfig)
	$(add_kdebase_dep kstyles)
	$(add_kdebase_dep ksysguard)
	$(add_kdebase_dep ksystraycmd)
	$(add_kdebase_dep kwin)
	$(add_kdebase_dep kwrite)
	$(add_kdebase_dep kwrited)
	$(add_kdebase_dep libkonq)
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep liboxygenstyle)
	$(add_kdebase_dep libplasmaclock)
	$(add_kdebase_dep libplasmagenericshell)
	$(add_kdebase_dep libtaskmanager)
	$(add_kdebase_dep nsplugins)
	$(add_kdebase_dep phonon-kde)
	$(add_kdebase_dep plasma-apps)
	$(add_kdebase_dep plasma-workspace)
	$(add_kdebase_dep powerdevil)
	$(add_kdebase_dep qguiplatformplugin_kde)
	$(add_kdebase_dep solid)
	$(add_kdebase_dep systemsettings)
	!prefix? ( $(add_kdebase_dep kdm) )
	$(block_other_slots)
"