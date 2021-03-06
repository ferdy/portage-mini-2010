# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faad/gst-plugins-faad-0.10.19.ebuild,v 1.6 2011/01/30 18:09:48 jer Exp $

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/faad2
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"
