# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomecanvas/libgnomecanvas-2.30.3.ebuild,v 1.2 2011/02/03 23:21:02 eva Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2 multilib virtualx

DESCRIPTION="The Gnome 2 Canvas library"
HOMEPAGE="http://library.gnome.org/devel/libgnomecanvas/stable/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc glade"

RDEPEND=">=dev-libs/glib-2.10:2
	>=x11-libs/gtk+-2.13:2
	>=media-libs/libart_lgpl-2.3.8
	>=x11-libs/pango-1.0.1
	glade? ( >=gnome-base/libglade-2 )"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	sys-devel/gettext
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.18
	doc? ( >=dev-util/gtk-doc-1 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF} $(use_enable glade) --disable-static"
}

src_prepare() {
	gnome2_src_prepare

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
		|| die "sed failed"

	# Don't build demos that are not even installed, bug #226299
	sed 's/^\(SUBDIRS =.*\)demos\(.*\)$/\1\2/' -i Makefile.am Makefile.in \
		|| die "sed 2 failed"
}

src_install() {
	gnome2_src_install

	if use glade; then
		# libglade doesn't need .la files
		find "${ED}/usr/$(get_libdir)/libglade/2.0" -name "*.la" -delete || die
	fi
}

src_test() {
	Xemake check || die "Test phase failed"
}
