# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mt-daapd/mt-daapd-0.2.4.2.ebuild,v 1.8 2010/01/07 14:39:07 fauli Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A multi-threaded implementation of Apple's DAAP server"
HOMEPAGE="http://www.mt-daapd.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ~mips ppc sh sparc x86 ~amd64-linux ~x86-linux"
IUSE="+avahi vorbis"

RDEPEND="media-libs/libid3tag
	sys-libs/gdbm
	avahi? ( net-dns/avahi[dbus] )
	!avahi? ( net-misc/mDNSResponder )
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	cp "${FILESDIR}"/${PN}.init.2 initd

	if use avahi; then
		sed -i -e 's:#USEHOWL need mDNSResponderPosix:need avahi-daemon:' initd
	else
		sed -i -e 's:#USEHOWL ::' initd
	fi

	epatch "${FILESDIR}"/${PN}-0.2.3-sparc.patch \
		"${FILESDIR}"/${PN}-0.2.4.1-libsorder.patch \
		"${FILESDIR}"/${PN}-0.2.4.1-pidfile.patch \
		"${FILESDIR}"/${P}-maintainer-mode.patch \
		"${FILESDIR}"/${P}-oggvorbis.patch
	eautoreconf
}

src_configure() {
	local myconf

	if use avahi; then
		myconf="--enable-avahi --disable-mdns"
	else
		myconf="--disable-avahi --enable-mdns"
	fi

	econf $(use_enable vorbis oggvorbis) \
		--disable-maintainer-mode \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	insinto /etc
	newins contrib/mt-daapd.conf mt-daapd.conf.example
	doins contrib/mt-daapd.playlist

	newinitd initd ${PN}

	keepdir /var/cache/mt-daapd /etc/mt-daapd.d
	dodoc AUTHORS ChangeLog CREDITS NEWS README TODO
}

pkg_postinst() {
	einfo
	elog "You have to configure your mt-daapd.conf following"
	elog "/etc/mt-daapd.conf.example file."
	einfo

	if use vorbis; then
		einfo
		elog "You need to edit you extensions list in /etc/mt-daapd.conf"
		elog "if you want your mt-daapd to serve ogg files."
		einfo
	fi

	einfo
	elog "If you want to start more than one ${PN} service, symlink"
	elog "/etc/init.d/${PN} to /etc/init.d/${PN}.<name>, and it will"
	elog "load the data from /etc/${PN}.d/<name>.conf."
	elog "Make sure that you have different cache directories for them."
	einfo
}
