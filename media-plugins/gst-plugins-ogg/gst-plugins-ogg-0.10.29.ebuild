# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ogg/gst-plugins-ogg-0.10.29.ebuild,v 1.9 2010/09/11 09:54:35 nixnut Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libogg-1.0"
DEPEND="${RDEPEND}"
