# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/genius/genius-1.0.9.ebuild,v 1.2 2010/09/14 09:25:20 hwoarang Exp $

EAPI=2
inherit gnome2

DESCRIPTION="Genius Mathematics Tool and the GEL Language"
HOMEPAGE="http://www.jirka.org/${PN}.html"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gnome nls"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/1.0/${P}.tar.bz2
	doc? ( http://www.jirka.org/${PN}-reference.pdf )"

RDEPEND="dev-libs/glib:2
	dev-libs/gmp
	dev-libs/mpfr
	dev-libs/popt
	sys-libs/ncurses
	sys-libs/readline
	gnome? ( x11-libs/gtk+:2
		gnome-base/libgnome
		gnome-base/libgnomeui
		gnome-base/libglade
		x11-libs/gtksourceview
		x11-libs/vte )"
DEPEND="${RDEPEND}
	dev-util/intltool
	|| ( sys-devel/bison
		dev-util/yacc )
	sys-devel/flex
	app-text/scrollkeeper
	nls? ( sys-devel/gettext )"

G2CONF="${G2CONF} $(use_enable gnome) $(use_enable nls) \
		--disable-update-mimedb --disable-scrollkeeper \
		--disable-extra-gcc-optimization"
GCONF_DEBUG="no"
DOCS="AUTHORS ChangeLog NEWS README TODO"
USE_DESTDIR="1"

src_install() {
	gnome2_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}"/${PN}-reference.pdf
	fi
}
