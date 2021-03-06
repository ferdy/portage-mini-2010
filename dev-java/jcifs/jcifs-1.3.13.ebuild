# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcifs/jcifs-1.3.13.ebuild,v 1.5 2010/05/23 17:47:41 pacho Exp $

EAPI="2"
JAVA_PKG_IUSE="doc examples source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Library that implements the CIFS/SMB networking protocol in Java"
SRC_URI="http://jcifs.samba.org/src/${P}.tgz"
HOMEPAGE="http://jcifs.samba.org/"
LICENSE="LGPL-2.1"
SLOT="1.1"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
RDEPEND=">=virtual/jre-1.4
	dev-java/servletapi:2.4"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"
IUSE=""

S=${WORKDIR}/${P/-/_}

java_prepare() {
	rm -v *.jar || die
	rm -v examples/*.class || die
}

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_EXTRA_ARGS="-DhasServlet=true"
EANT_GENTOO_CLASSPATH="servletapi-2.4"

src_install() {
	java-pkg_newjar ${P}.jar

	dodoc README.txt || die
	# other stuff besides javadocs
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/*
	use examples && java-pkg_doexamples examples
}
