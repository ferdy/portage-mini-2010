# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/luckybackup/luckybackup-0.4.3.ebuild,v 1.2 2010/11/02 01:34:59 tampakrap Exp $

EAPI=2
inherit qt4-r2

DESCRIPTION="Powerful and flexible backup (and syncing) tool, using RSync and Qt4"
HOMEPAGE="http://luckybackup.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4
	net-misc/rsync"
RDEPEND="${DEPEND}"

DOCSDIR="${S}/readme"
DOCS="AUTHORS changelog README TODO TRANSLATIONS"

src_prepare() {
	sed -i \
		-e 's:/usr/share/doc/luckybackup:/usr/share/doc/${PF}:g' \
		-e 's:/usr/share/doc/packages/luckybackup:/usr/share/doc/${PF}:g' \
		luckybackup.pro src/global.h || die
}
