# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/twm/twm-1.0.6.ebuild,v 1.4 2011/02/14 23:44:42 xarthisius Exp $

EAPI=3

XORG_STATIC=no
inherit xorg-2

DESCRIPTION="X.Org twm application"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXmu
	x11-libs/libICE
	x11-libs/libSM"
DEPEND="${RDEPEND}
	sys-devel/bison"
