# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-acpi-notifier/claws-mail-acpi-notifier-1.0.24.ebuild,v 1.4 2011/01/15 14:35:09 maekke Exp $

inherit eutils

MY_P="${P#claws-mail-}"
MY_P="${MY_P/-/_}"

DESCRIPTION="This plugin enables mail notification via LEDs on some laptops."
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND=">=mail-client/claws-mail-3.7.7"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f "${D}"/usr/lib*/claws-mail/plugins/*.{a,la}
}

pkg_postinst() {
	PROC_IFACES="$(echo /proc/acpi/{asus/mled,ibm/led,acer/mailled}) /proc/driver/acerhk/led"

	local procfile
	local message_shown=false

	for procfile in ${PROC_IFACES}; do
		if [[ -f ${procfile} ]]; then
			elog "Make sure ${procfile} is writable by users of this plugin."
			message_shown=true
		fi
	done
}
