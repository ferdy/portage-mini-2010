# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/apple-java-extensions-bin/apple-java-extensions-bin-1.5.ebuild,v 1.1 2011/01/30 22:12:37 fordfrog Exp $

EAPI="3"

inherit java-pkg-2

DESCRIPTION="A pluggable jar of stub classes representing the new Apple eAWT and eIO APIs for Java on Mac OS X."
HOMEPAGE="http://developer.apple.com/samplecode/AppleJavaExtensions/"
SRC_URI="http://developer.apple.com/samplecode/AppleJavaExtensions/AppleJavaExtensions.zip -> ${P}.zip"
LICENSE="Apple"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.5"

S=${WORKDIR}/AppleJavaExtensions

src_install() {
	dodoc README.txt
	java-pkg_dojar AppleJavaExtensions.jar
}
