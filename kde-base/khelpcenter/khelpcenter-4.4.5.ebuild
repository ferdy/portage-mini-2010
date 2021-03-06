# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khelpcenter/khelpcenter-4.4.5.ebuild,v 1.8 2010/09/14 12:53:58 reavertm Exp $

EAPI="3"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Help Center"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdelibs 'handbook')
	>=www-misc/htdig-3.2.0_beta6-r1
"

KMEXTRA="
	doc/faq/
	doc/glossary/
	doc/khelpcenter/
	doc/quickstart/
	doc/userguide/
	doc/visualdict/
"
