# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/utempter/utempter-0.5.5.6.ebuild,v 1.16 2010/10/08 02:25:40 leio Exp $

inherit rpm eutils

MY_P=${P%.*}-${PV##*.}
S=${WORKDIR}/${P%.*}
DESCRIPTION="App that allows non-privileged apps to write utmp (login) info"
HOMEPAGE="http://www.redhat.com/"
SRC_URI="mirror://gentoo/${MY_P}.src.rpm"

LICENSE="|| ( MIT LGPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="!virtual/utempter"
PROVIDE="virtual/utempter"

pkg_setup() {
	enewgroup utmp 406
}

src_unpack() {
	rpm_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/${P}-soname-makefile-fix.patch
	epatch "${FILESDIR}"/${P}-no_utmpx.patch
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	emake RPM_OPT_FLAGS="${CFLAGS} ${CPPFLAGS}" || die
}

src_install() {
	emake \
		RPM_BUILD_ROOT="${D}" \
		LIBDIR=/usr/$(get_libdir) \
		install || die
	dobin utmp || die

	fowners root:utmp /usr/sbin/utempter
	fperms 2755 /usr/sbin/utempter
}

pkg_postinst() {
	if [ -f "${ROOT}"/var/log/wtmp ] ; then
		chown root:utmp "${ROOT}"/var/log/wtmp
		chmod 664 "${ROOT}"/var/log/wtmp
	fi
	if [ -f "${ROOT}"/var/run/utmp ] ; then
		chown root:utmp "${ROOT}"/var/run/utmp
		chmod 664 "${ROOT}"/var/run/utmp
	fi
}
