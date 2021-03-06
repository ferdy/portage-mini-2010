# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/latin-euro-standards/latin-euro-standards-1.08.ebuild,v 1.1 2009/02/22 10:32:37 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Support for the Latin{7,8,9,10} character sets & coding systems."
PKG_CAT="mule"

RDEPEND="app-xemacs/mule-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages
