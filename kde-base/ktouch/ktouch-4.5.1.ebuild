# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktouch/ktouch-4.5.1.ebuild,v 1.2 2010/09/06 04:51:12 reavertm Exp $

EAPI="3"

KDE_HANDBOOK=1
KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="KDE: A program that helps you to learn and practice touch typing"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep knotify)
"