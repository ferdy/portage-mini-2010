# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/geant/geant-4.9.4.ebuild,v 1.3 2011/02/13 12:44:57 armin76 Exp $

EAPI=3

inherit cmake-utils versionator eutils

PV1=$(get_version_component_range 1 ${PV})
PV2=$(get_version_component_range 2 ${PV})
PV3=$(get_version_component_range 3 ${PV})

MYP=${PN}$(replace_version_separator 3 .)

DESCRIPTION="Toolkit for simulation of passage of particles through matter"
HOMEPAGE="http://geant4.cern.ch/"

SRC_COM="http://geant4.cern.ch/support/source"
SRC_URI="${SRC_COM}/${MYP}.tar.gz"
GEANT4_DATA="G4NDL.3.14
	G4EMLOW.6.19
	G4RadioactiveDecay.3.3
	G4NEUTRONXS.1.0
	G4PII.1.2
	G4PhotonEvaporation.2.1
	G4ABLA.3.0
	RealSurface.1.0"
for d in ${GEANT4_DATA}; do
	SRC_URI="${SRC_URI} data? ( ${SRC_COM}/${d}.tar.gz )"
done

LICENSE="geant4"
SLOT="4"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="+data dawn examples gdml geant3 granular qt4 static-libs vrml zlib"

RDEPEND=">=sci-physics/clhep-2.1
	qt4? ( x11-libs/qt-gui:4 x11-libs/qt-opengl:4 )
	gdml? ( dev-libs/xerces-c )
	geant3? ( sci-physics/geant:3 )
	dawn? ( media-gfx/dawn )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYP}"

PATCHES=( "${FILESDIR}"/${P}-{no-benchmarks,zlib,libdir,datadir,no-examples}.patch )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable dawn GEANT4_USE_NETWORKDAWN)
		$(cmake-utils_use_enable gdml GEANT4_USE_GDML)
		$(cmake-utils_use_enable geant3 GEANT4_USE_GEANT3TOGEANT4)
		$(cmake-utils_use_enable granular GEANT4_BUILD_GRANULAR_BUILD)
		$(cmake-utils_use_enable vrml GEANT4_USE_NETWORKVRML)
		$(cmake-utils_use_enable qt4 GEANT4_USE_QT)
		$(cmake-utils_use_enable zlib GEANT4_USE_SYSTEM_ZLIB)
		$(cmake-utils_use_build static-libs STATIC_LIBS)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	if use data; then
		einfo "Installing Geant4 data"
		insinto /usr/share/geant4/data
		pushd "${WORKDIR}" > /dev/null
		for d in ${GEANT4_DATA}; do
			local p=${d/.}
			doins -r *${p/G4} || die "installing data ${d} failed"
		done
		popd > /dev/null
	fi

	insinto /usr/share/doc/${PF}
	local mypv="${PV1}.${PV2}.${PV3}"
	doins ReleaseNotes/ReleaseNotes${mypv}.html
	[[ -e ReleaseNotes/Patch${mypv}-1.txt ]] && \
		dodoc ReleaseNotes/Patch${mypv}-*.txt
	use examples && doins -r examples
}

pkg_postinst() {
	elog "Users need to define the G4WORKDIR (\$HOME/geant4 is normally used)."
}
