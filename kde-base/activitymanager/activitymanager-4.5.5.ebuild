# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/activitymanager/activitymanager-4.5.5.ebuild,v 1.1 2011/01/10 11:53:18 tampakrap Exp $

EAPI="3"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Activity manager"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

KMEXTRACTONLY="
	nepomuk/services/activities/org.kde.nepomuk.ActivitiesService.xml
"
