# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/killbots/killbots-4.5.2.ebuild,v 1.1 2010/10/06 09:17:21 alexxy Exp $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="Kill the bots or they kill you!"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# Tests hang, last checked in 4.3.3
RESTRICT="test"