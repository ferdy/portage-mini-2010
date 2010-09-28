# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kchart/kchart-2.2.2.ebuild,v 1.1 2010/09/25 20:27:27 dilfridge Exp $

EAPI=2

DESCRIPTION="KOffice chart application. Temporary dummy ebuild for compatibility."

SRC_URI=""
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="2"
LICENSE="GPL-2"

IUSE="reports"

DEPEND="~app-office/koffice-libs-${PV}:${SLOT}[reports=]"
RDEPEND=${DEPEND}