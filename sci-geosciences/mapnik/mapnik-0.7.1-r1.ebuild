# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/mapnik/mapnik-0.7.1-r1.ebuild,v 1.3 2011/02/07 06:54:11 nerdboy Exp $

EAPI=2

PYTHON_DEPEND="python? 2"
inherit eutils flag-o-matic python distutils toolchain-funcs versionator

DESCRIPTION="A Free Toolkit for developing mapping applications."
HOMEPAGE="http://www.mapnik.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cairo curl debug doc +gdal postgres python sqlite"

RDEPEND="dev-libs/boost
	dev-libs/icu
	dev-libs/libxml2
	media-fonts/dejavu
	media-libs/freetype:2
	virtual/jpeg
	media-libs/libpng
	media-libs/tiff
	sci-libs/proj
	x11-libs/agg[truetype]
	cairo? (
		x11-libs/cairo
		dev-cpp/cairomm
	)
	curl? ( net-misc/curl )
	gdal? ( sci-libs/gdal )
	postgres? (
		>=dev-db/postgresql-base-8.3
		>=dev-db/postgis-1.5.2
	)
	python? ( dev-libs/boost[python] )
	sqlite? ( dev-db/sqlite:3 )"

DEPEND="${RDEPEND}
	doc? ( dev-python/epydoc )
	dev-util/scons"

src_prepare() {
	sed -i \
		-e "s|/usr/local|/usr|g" \
		-e "s|Action(env\[config\]|Action('%s --help' % env\[config\]|" \
		SConstruct || die "sed 1 failed"

	sed -i \
		-e "s:mapniklibpath + '/fonts':'/usr/share/fonts/dejavu/':g" \
	    bindings/python/SConscript || die "sed 2 failed"
	rm -rf agg || die
	epatch "${FILESDIR}"/${P}-libagg.patch
}

src_configure() {
	EMAKEOPTS="SYSTEM_FONTS=/usr/share/fonts/dejavu"

	EMAKEOPTS="${EMAKEOPTS} INPUT_PLUGINS="
	use postgres && EMAKEOPTS="${EMAKEOPTS}postgis,"
	use gdal     && EMAKEOPTS="${EMAKEOPTS}gdal,ogr,"
	use sqlite   && EMAKEOPTS="${EMAKEOPTS}sqlite,"
	use curl     && EMAKEOPTS="${EMAKEOPTS}osm,"
	EMAKEOPTS="${EMAKEOPTS}shape,raster"

	use cairo  || EMAKEOPTS="${EMAKEOPTS} CAIRO=false"
	use python || EMAKEOPTS="${EMAKEOPTS} BINDINGS=none"
	use debug  && EMAKEOPTS="${EMAKEOPTS} DEBUG=yes"

	use postgres && use sqlite && EMAKEOPTS="${EMAKEOPTS} PGSQL2SQLITE=yes"

	BOOST_PKG="$(best_version "dev-libs/boost")"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	export BOOST_VERSION="$(replace_all_version_separators _ "${BOOST_VER}")"
	elog "${P} BOOST_VERSION is ${BOOST_VERSION}"
	export BOOST_INC="/usr/include/boost-${BOOST_VERSION}"
	elog "${P} BOOST_INC is ${BOOST_INC}"
	BOOST_LIBDIR_SCHEMA="$(get_libdir)/boost-${BOOST_VERSION}"
	export BOOST_LIB="/usr/${BOOST_LIBDIR_SCHEMA}"
	elog "${P} BOOST_LIB is ${BOOST_LIB}"

	# Passing things doesn't seem to hit all the right paths; another
	# poster-child for just a bit too much complexity for its own good.
	# See bug #301674 for more info.
	sed -i -e "s|searchDir, LIBDIR_SCHEMA|searchDir, \'${BOOST_LIBDIR_SCHEMA}\'|" \
		-i -e "s|include/boost*|include/boost-${BOOST_VERSION}|" \
		"${S}"/SConstruct || die "sed boost paths failed..."

	# this seems to be the only way to force user-flags, since nothing
	# gets through the scons configure except the nuclear sed option.
	sed -i -e "s:\-O%s:${CXXFLAGS}:" \
		-i -e "s:env\['OPTIMIZATION'\]\,::" \
		SConstruct || die "sed 3 failed"
	sed -i -e "s:LINKFLAGS=linkflags:LINKFLAGS=linkflags + \" ${LDFLAGS}\":" \
		src/SConscript || die "sed 4 failed"

	scons CC="$(tc-getCC)" CXX="$(tc-getCXX)" ${EMAKEOPTS} configure \
		|| die "scons configure failed"
}

src_compile() {
	# note passing CXXFLAGS to scons does *not* work
	scons CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		shared=1 || die "scons make failed"

	if use doc; then
		export PYTHONPATH="${S}/bindings/python:$(python_get_sitedir)"
		cd docs/epydoc_config
		./build_epydoc.sh || die "API doc generation failed"
		cd -
	fi
}

src_install() {
	scons DESTDIR="${D}" install || die "scons install failed"

	if use python ; then
	    fperms 0755 "$(python_get_sitedir)"/mapnik/paths.py
	    dobin utils/stats/mapdef_stats.py
	    insinto /usr/share/doc/${PF}/examples
	    doins utils/ogcserver/*
	fi

	dodoc AUTHORS CHANGELOG README || die
	use doc && { dohtml -r docs/api_docs/python/* || die "API doc install failed"; }
}

pkg_postinst() {
	elog ""
	elog "See the home page or the OpenStreetMap wiki for more info, and"
	elog "the installed examples for the default mapnik ogcserver config."
	elog ""
}
