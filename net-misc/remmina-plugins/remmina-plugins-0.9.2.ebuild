# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/remmina-plugins/remmina-plugins-0.9.2.ebuild,v 1.1 2011/01/22 16:11:25 hwoarang Exp $

EAPI=2
inherit gnome2-utils

DESCRIPTION="Set of plugins for Remmina GTK+ RDP, VNC, XDMCP and SSH client"
HOMEPAGE="http://remmina.sourceforge.net/"
SRC_URI="mirror://sourceforge/remmina/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls nx rdesktop ssh telepathy vnc xdmcp"

RDEPEND=">=net-misc/remmina-0.8.0
	nls? ( virtual/libintl )
	nx? ( net-misc/nx )
	rdesktop? ( net-misc/freerdp )
	xdmcp? ( x11-base/xorg-server[kdrive] )
	ssh? ( net-libs/libssh[sftp] )
	vnc? ( net-libs/libvncserver )"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	telepathy? ( >=net-libs/telepathy-glib-0.9.0 ) "

src_configure() {
	local myconf="--disable-dependency-tracking"
	if use nx && ! use ssh; then
		myconf="${myconf} --disable-nx"
		ewarn "nx support requires ssh."
		ewarn "nx support will not be included."
	else
		myconf="${myconf} --enable-nx"
	fi

	econf \
		${myconf} \
		$(use_enable nls) \
		$(use_enable rdesktop rdp) \
		$(use_enable ssh) \
		$(use_enable telepathy) \
		$(use_enable vnc ) \
		$(use_enable xdmcp)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
