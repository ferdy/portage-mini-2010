# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/ghemical/ghemical-2.99.2-r2.ebuild,v 1.4 2010/10/10 11:16:32 hwoarang Exp $

EAPI="3"

inherit autotools eutils

DESCRIPTION="Chemical quantum mechanics and molecular mechanics"
HOMEPAGE="http://bioinformatics.org/ghemical/"
SRC_URI="http://bioinformatics.org/ghemical/download/current/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="openbabel seamonkey threads"

RDEPEND="
	dev-libs/glib:2
	gnome-base/libglade
	sci-chemistry/mpqc
	>=sci-libs/libghemical-2.99
	>=x11-libs/liboglappth-0.98
	virtual/opengl
	x11-libs/pango
	x11-libs/gtk+:2
	x11-libs/gtkglext
	openbabel? ( sci-chemistry/openbabel )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-docs.patch
	eautoreconf
}

src_configure() {
# With amd64, if you want gamess I recommend adding gamess and gtk-gamess to package.provided for now.

# Change the built-in help browser.
	if use seamonkey ; then
		sed -i -e 's|mozilla|seamonkey|g' src/gtk_app.cpp || die "sed failed for seamonkey!"
	else
		sed -i -e 's|mozilla|firefox|g' src/gtk_app.cpp || die "sed failed for firefox!"
	fi

	econf \
		$(use_enable openbabel) \
		$(use_enable threads)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	make_desktop_entry /usr/bin/ghemical Ghemical /usr/share/ghemical/${PV}/pixmaps/ghemical.png
}
