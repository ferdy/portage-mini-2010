# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/yawp/yawp-0.3.5.ebuild,v 1.2 2011/01/09 08:20:41 scarabeus Exp $

EAPI=3
KDE_LINGUAS="af cs de es fr he it pl ru sk sl uk"
inherit kde4-base

DESCRIPTION="Yet Another Weather Plasmoid"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=94106"
SRC_URI="mirror://sourceforge/yawp/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND=">=kde-base/plasma-workspace-${KDE_MINIMAL}"

DOCS="README TODO"
