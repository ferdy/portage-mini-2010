# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xbacklight/xbacklight-1.1.1.ebuild,v 1.9 2010/01/18 19:08:06 armin76 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Sets backlight level using the RandR 1.2 BACKLIGHT output property"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""
RDEPEND=">=x11-libs/libXrandr-1.2"
DEPEND="${RDEPEND}"
