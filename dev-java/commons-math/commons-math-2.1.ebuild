# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-math/commons-math-2.1.ebuild,v 1.1 2010/10/24 09:09:34 serkan Exp $

EAPI="3"

JAVA_PKG_IUSE="doc test source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Lightweight, self-contained mathematics and statistics components"
HOMEPAGE="http://commons.apache.org/math/"
SRC_URI="mirror://apache/commons/math/source/${P}-src.tar.gz"
LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=virtual/jdk-1.5
	test? (
		dev-java/ant-junit4
		dev-java/hamcrest-core:0
	)"

RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}/${P}-src"

java_prepare() {
	epatch "${FILESDIR}"/${P}-buildfixes.patch
}

src_test() {
	java-pkg_jar-from junit-4
	java-pkg_jar-from hamcrest-core
	ANT_TASKS="ant-junit4" eant -Djunit.jar=junit.jar test
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar

#	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/main/java/org
}