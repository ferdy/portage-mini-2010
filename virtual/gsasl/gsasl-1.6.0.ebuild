# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/gsasl/gsasl-1.6.0.ebuild,v 1.1 2011/01/09 17:33:33 jer Exp $

EAPI="2"

DESCRIPTION="Virtual for the GNU SASL library"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="|| ( =net-libs/libgsasl-${PV} =net-misc/${P} )"
RDEPEND="${DEPEND}"
