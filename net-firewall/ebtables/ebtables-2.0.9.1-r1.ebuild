# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ebtables/ebtables-2.0.9.1-r1.ebuild,v 1.3 2009/12/06 22:47:01 flameeyes Exp $

EAPI="2"

inherit versionator eutils toolchain-funcs multilib flag-o-matic

MY_PV=$(replace_version_separator 3 '-' )
MY_P=${PN}-v${MY_PV}

DESCRIPTION="Utility that enables basic Ethernet frame filtering on a Linux bridge, MAC NAT and brouting."
HOMEPAGE="http://ebtables.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static"
LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if use static; then
		ewarn "You've chosen static build which is useful for embedded devices."
		ewarn "It has no init script. Make sure that's really what you want."
	fi
}

src_prepare() {
	# Enhance ebtables-save to take table names as parameters bug #189315
	epatch "${FILESDIR}/${PN}-2.0.8.1-ebt-save.diff"
	epatch "${FILESDIR}/${PN}-v2.0.9-1-LDFLAGS.diff"
	epatch "${FILESDIR}/${PN}-v2.0.8-2-ethertype-DESTDIR-mkdir.patch"

	sed -i -e "s,^MANDIR:=.*,MANDIR:=/usr/share/man," \
		-e "s,^BINDIR:=.*,BINDIR:=/sbin," \
		-e "s,^INITDIR:=.*,INITDIR:=/usr/share/doc/${PF}," \
		-e "s,^SYSCONFIGDIR:=.*,SYSCONFIGDIR:=/usr/share/doc/${PF}," \
		-e "s,^LIBDIR:=.*,LIBDIR:=/$(get_libdir)/\$(PROGNAME)," Makefile
	sed -i -e "s/^CFLAGS:=/CFLAGS+=/" Makefile
	sed -i -e "s,^CC:=.*,CC:=$(tc-getCC)," Makefile
}

src_compile() {
	# This package uses _init functions to initialise extensions. With
	# --as-needed this will not work.
	append-ldflags $(no-as-needed)
	emake $(use static && echo static) || die "emake failed"
}

src_install() {
	if ! use static; then
		make DESTDIR="${D}" install || die
		keepdir /var/lib/ebtables/
		newinitd "${FILESDIR}"/ebtables.initd ebtables || die
		newconfd "${FILESDIR}"/ebtables.confd ebtables || die
	else
		into /
		newsbin static ebtables || die
	fi
	dodoc ChangeLog THANKS || die
}
