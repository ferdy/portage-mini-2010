# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmpdclient/qmpdclient-1.2.1.ebuild,v 1.1 2011/02/18 14:53:09 angelos Exp $

EAPI="2"

LANGSLONG="cs_CZ de_DE fr_FR it_IT nl_NL nn_NO no_NO ru_RU sv_SE tr_TR uk_UA"
LANGS="zh_CN zh_TW pt_BR "

inherit qt4-r2

DESCRIPTION="QMPDClient with NBL additions, such as lyrics' display"
HOMEPAGE="http://bitcheese.net/wiki/QMPDClient"
SRC_URI="http://dump.bitcheese.net/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug dbus"

DEPEND="x11-libs/qt-gui:4[dbus?]
	x11-libs/qt-webkit:4
	x11-libs/qt-xmlpatterns:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

DOCS="AUTHORS README THANKSTO Changelog"

src_prepare() {
	# Fix the install path
	sed -i -e "s:PREFIX = /usr/local:PREFIX = /usr:" ${PN}.pro \
		|| die "sed failed (install path)"

	# nostrip fix
	sed -i -e "s:^CONFIG += :CONFIG += nostrip :" ${PN}.pro \
		|| die "sed failed (nostrip)"

	sed -i -e "s:+= -O2 -g0 -s:+= -O2 -g0:" ${PN}.pro \
		|| die "sed failed (nostrip)"

	# fix installation folder name
	sed -i "s:share/QMPDClient:share/qmpdclient:" ${PN}.pro src/config.cpp \
		|| die "failed to fix installation directory"

	# check dbus
	if ! use dbus; then
		sed -i -e "s/message(DBus notifier:\ enabled)/message(DBus notifier:\ disabled)/" \
			-e "s/CONFIG\ +=\ nostrip\ qdbus//" \
			-e "s/SOURCES\ +=\ src\/notifications_dbus.cpp/SOURCES\ +=\ src\/notifications_nodbus.cpp/" \
			${PN}.pro || die "disabling dbus failed"
	fi
	qt4-r2_src_prepare
}

src_compile() {
	emake || die "emake failed"
	# generate translations
	emake translate || die "failed to generate translations"
	cd "${S}"/lang
	for X in *.ts;do
		lrelease "${X}" || die "lrelease failed"
	done
}

src_install() {
	qt4-r2_src_install

	#install translations
	insinto /usr/share/${PN}/translations/
	local LANG=
	for LANG in ${LINGUAS};do
	    for X in ${LANGSLONG};do
			if [[ ${LANG} == ${X%_*} ]];then
		    	doins -r lang/${X}.qm || die "failed to install translations"
			fi
	    done
		for X in ${LANGS};do
			if [[ ${LANG} == ${X} ]]; then
				doins -r lang/${X}.qm || die "failed to install translations"
			fi
		done
	done
}
