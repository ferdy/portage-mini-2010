# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/konversation/konversation-1.3.1.ebuild,v 1.5 2011/01/28 15:52:38 scarabeus Exp $

EAPI=3
KDE_LINGUAS="bg ca cs da de el en_GB es et fi fr gl hu it ja nb nds nl pa pl pt
pt_BR ru sk sr sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
KDE_HANDBOOK="optional"
inherit kde4-base

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="A user friendly IRC Client for KDE4"
HOMEPAGE="http://konversation.kde.org"
SRC_URI="mirror://kde/stable/${PN}/${MY_PV}/src/${MY_P}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="+crypt debug"

DEPEND="x11-libs/libXScrnSaver
	$(add_kdebase_dep kdepimlibs)
	crypt? ( app-crypt/qca:2 )"
RDEPEND="${DEPEND}"

DOCS="AUTHORS ChangeLog NEWS README TODO"

S="${WORKDIR}/${MY_P}"

src_configure() {
	mycmakeargs+=(
		$(cmake-utils_use_with crypt QCA2)
	)

	kde4-base_src_configure
}
