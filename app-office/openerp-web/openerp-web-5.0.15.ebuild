# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openerp-web/openerp-web-5.0.15.ebuild,v 1.1 2011/01/06 08:14:03 elvanor Exp $

EAPI="2"

inherit eutils distutils

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://www.openerp.com/"
SRC_URI="http://www.openerp.com/download/stable/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="=dev-python/cherrypy-3.1*
	dev-python/mako
	dev-python/Babel
	dev-python/formencode
	dev-python/simplejson
	dev-python/beaker"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/gentoo.patch"
}

src_install() {
	distutils_src_install

	doinitd "${FILESDIR}/${PN}"
	newconfd "${FILESDIR}/openerp-web-confd" "${PN}"

	dodir /etc/openerp
	keepdir /var/run/openerp
	keepdir /var/log/openerp
	insinto /etc/openerp

	doins config/${PN}.cfg

	dodoc doc/*
}
