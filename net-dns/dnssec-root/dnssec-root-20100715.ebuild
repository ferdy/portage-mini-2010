# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnssec-root/dnssec-root-20100715.ebuild,v 1.2 2010/11/30 15:27:35 mr_bones_ Exp $

DESCRIPTION="The DNSSEC root key(s)"
HOMEPAGE="https://www.iana.org/dnssec/"
SRC_URI="http://data.iana.org/root-anchors/root-anchors.xml
		http://data.iana.org/root-anchors/Kjqmt7v.csr
		test? ( http://data.iana.org/root-anchors/Kjqmt7v.crt
				http://data.iana.org/root-anchors/root-anchors.p7s
				http://data.iana.org/root-anchors/root-anchors.asc
				http://data.iana.org/root-anchors/icannbundle.pem
				http://data.iana.org/root-anchors/icann.pgp
				)"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="test"

DEPEND="dev-libs/libxslt
		test? ( app-crypt/gnupg )"
RDEPEND=""

S="${WORKDIR}"

# xsl and checking as per:
# http://permalink.gmane.org/gmane.network.dns.unbound.user/1039

src_unpack() {
	einfo 'unpack not needed'
}

src_compile() {
	xsltproc -o "${S}"/root-anchors.txt "${FILESDIR}"/anchors2ds.xsl "${DISTDIR}"/root-anchors.xml || die 'xsl translation failed'
}

src_test()
{
	gpg --import "${DISTDIR}"/icann.pgp || die 'icann key import failed'
	gpg --verify "${DISTDIR}"/root-anchors.asc "${DISTDIR}"/root-anchors.xml || \
		die 'gpg verification of the root key failed'
	openssl smime  -verify -content "${DISTDIR}"/root-anchors.xml \
		-in "${DISTDIR}"/root-anchors.p7s -inform der \
		-CAfile "${DISTDIR}"/icannbundle.pem \
		|| die 'smime verification of the root key failed'
}

src_install() {
	insinto /etc/dnssec
	doins root-anchors.txt "${DISTDIR}"/root-anchors.xml "${DISTDIR}"/Kjqmt7v.csr
}
