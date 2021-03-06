# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/sun/sun-1.16.ebuild,v 1.6 2008/05/05 13:29:28 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Support for Sparcworks.."
PKG_CAT="standard"

MY_PN="Sun"
SRC_URI="http://ftp.xemacs.org/packages/${MY_PN}-${PV}-pkg.tar.gz"

RDEPEND="app-xemacs/cc-mode
app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 ppc sparc x86"

inherit xemacs-packages
