# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx-sunpinyin/fcitx-sunpinyin-0.2.1.ebuild,v 1.1 2010/12/18 09:15:30 qiaomuf Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="sunpinyin IM for fcitx"
HOMEPAGE="http://fcitx.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPEND=" >=app-i18n/sunpinyin-2.0.2
	>=app-i18n/fcitx-4.0.1 "
RDEPEND="${DEPEND}"
