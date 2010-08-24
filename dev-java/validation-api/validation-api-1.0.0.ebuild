# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/validation-api/validation-api-1.0.0.ebuild,v 1.1 2010/08/19 17:11:37 nelchael Exp $

EAPI=3

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Bean Validation (JSR-303) API"
HOMEPAGE="http://fisheye.jboss.org/browse/Hibernate/beanvalidation/api/tags/v1_0_0_GA"
SRC_URI="https://repository.jboss.org/nexus/service/local/repo_groups/public/content/javax/validation/${PN}/${PV}.GA/${P}.GA-sources.jar"

LICENSE="Apache-2.0"
SLOT="1.0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip"

EANT_BUILD_TARGET="jar"
EANT_DOC_TARGET="doc"

S="${WORKDIR}/${PN}"

src_unpack() {
	mkdir -p "${S}/src"
	cd "${S}/src"
	unpack ${A}
	cp "${FILESDIR}/build.xml" "${S}/"
}

src_install() {
	java-pkg_dojar "${PN}.jar"
	use doc && java-pkg_dojavadoc "${S}/api"
	use source && java-pkg_dosrc "${S}/src/javax"
}