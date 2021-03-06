# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundkonverter/soundkonverter-1.0.0_beta1.ebuild,v 1.3 2011/02/02 04:54:05 tampakrap Exp $

EAPI=3

inherit kde4-base

MY_PV="0.9.90"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A frontend to various audio converters"
HOMEPAGE="http://www.kde-apps.org/content/show.php/soundKonverter?content=29024"
SRC_URI="https://api.opensuse.org/public/source/home:HessiJames/${PN}-kde4/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	media-libs/taglib
	media-sound/cdparanoia
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
