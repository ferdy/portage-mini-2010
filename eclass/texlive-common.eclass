# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/texlive-common.eclass,v 1.14 2010/10/24 16:22:33 aballier Exp $

# @ECLASS: texlive-common.eclass
# @MAINTAINER:
# tex@gentoo.org
#
# Original Author: Alexis Ballier <aballier@gentoo.org>
# @BLURB: Provide various functions used by both texlive-core and texlive modules
# @DESCRIPTION:
# Purpose: Provide various functions used by both texlive-core and texlive
# modules.
#
# Note that this eclass *must* not assume the presence of any standard tex tool


TEXMF_PATH=/usr/share/texmf
TEXMF_DIST_PATH=/usr/share/texmf-dist
TEXMF_VAR_PATH=/var/lib/texmf

# @FUNCTION: texlive-common_handle_config_files
# @DESCRIPTION:
# Has to be called in src_install after having installed the files in ${D}
# This function will move the relevant files to /etc/texmf and symling them
# from their original location. This is to allow easy update of texlive's
# configuration

texlive-common_handle_config_files() {
	# Handle config files properly
	[ -d "${D}${TEXMF_PATH}" ] || return
	cd "${D}${TEXMF_PATH}"
	for f in $(find . -name '*.cnf' -type f -o -name '*.cfg' -type f | sed -e "s:\./::g") ; do
		if [ "${f#*config}" != "${f}" -o "${f#doc}" != "${f}" ] ; then
			continue
		fi
		dodir /etc/texmf/$(dirname ${f}).d
		einfo "Moving (and symlinking) ${TEXMF_PATH}/${f} to /etc/texmf/$(dirname ${f}).d"
		mv "${D}/${TEXMF_PATH}/${f}" "${D}/etc/texmf/$(dirname ${f}).d" || die "mv ${f} failed."
		dosym /etc/texmf/$(dirname ${f}).d/$(basename ${f}) ${TEXMF_PATH}/${f}
	done
}

# @FUNCTION: texlive-common_is_file_present_in_texmf
# @DESCRIPTION:
# Return if a file is present in the texmf tree
# Call it from the directory containing texmf and texmf-dist

texlive-common_is_file_present_in_texmf() {
	local mark="${T}/$1.found"
	find texmf -name $1 -exec touch "${mark}" \;
	find texmf-dist -name $1 -exec touch "${mark}" \;
	[ -f "${mark}" ]
}

# @FUNCTION: texlive-common_do_symlinks
# @USAGE: < src > < dest >
# @DESCRIPTION:
# Mimic the install_link function of texlinks
#
# Should have the same behavior as the one in /usr/bin/texlinks
# except that it is under the control of the package manager
# Note that $1 corresponds to $src and $2 to $dest in this function
# ( Arguments are switched because texlinks main function sends them switched )
# This function should not be called from an ebuild, prefer etexlinks that will
# also do the fmtutil file parsing.

texlive-common_do_symlinks() {
	while [ $# != 0 ]; do
		case $1 in
			cont-??|metafun|mptopdf)
				einfo "Symlink $1 skipped (special case)"
				;;
			mf)
				einfo "Symlink $1 -> $2 skipped (texlive-core takes care of it)"
				;;
			*)
				if [ $1 = $2 ];
				then
					einfo "Symlink $1 -> $2 skipped"
				elif [ -e "${D}/usr/bin/$1" ];
				then
					einfo "Symlink $1 skipped (file exists)"
				else
					einfo "Making symlink from $1 to $2"
					dosym $2 /usr/bin/$1
				fi
				;;
		esac
		shift; shift;
	done
}

# @FUNCTION: etexlinks
# @USAGE: < file > 
# @DESCRIPTION:
# Mimic texlinks on a fmtutil format file
#
# $1 has to be a fmtutil format file like fmtutil.cnf
# etexlinks foo will install the symlinks that texlinks --cnffile foo would have
# created. We cannot use texlinks with portage as it is not DESTDIR aware.
# (It would not fail but will not create the symlinks if the target is not in
# the same dir as the source)
# Also, as this eclass must not depend on a tex distribution to be installed we
# cannot use texlinks from here.

etexlinks() {
	# Install symlinks from formats to engines
	texlive-common_do_symlinks $(sed '/^[      ]*#/d; /^[      ]*$/d' "$1" | awk '{print $1, $2}')
}

# @FUNCTION: dobin_texmf_scripts
# @USAGE: < file1 file2 ... > 
# @DESCRIPTION:
# Symlinks a script from the texmf tree to /usr/bin. Requires permissions to be
# correctly set for the file that it will point to. 

dobin_texmf_scripts() {
	while [ $# -gt 0 ] ; do
		local trg=$(basename ${1} | sed 's,\.[^/]*$,,' | tr '[:upper:]' '[:lower:]')
		einfo "Installing ${1} as ${trg} bin wrapper"
		if [ "${PV#2008}" = "${PV}" -a "${PV#2009}" = "${PV}" ] ; then
			[ -x "${D}/usr/share/${1}" ] || die "Trying to install a non existing or non executable symlink to /usr/bin: ${1}"
		fi
		dosym ../share/${1} /usr/bin/${trg} || die "failed to install ${1} as $trg"
		shift
	done
}

# @FUNCTION: etexmf-update
# @USAGE: In ebuilds' pkg_postinst and pkg_postrm phases
# @DESCRIPTION:
# Runs texmf-update if it is available and prints a warning otherwise. This
# function helps in factorizing some code.

etexmf-update() {
	if [ "$ROOT" = "/" ] && [ -x /usr/sbin/texmf-update ] ; then
		/usr/sbin/texmf-update
	else
		ewarn "Cannot run texmf-update for some reason."
		ewarn "Your texmf tree might be inconsistent with your configuration"
		ewarn "Please try to figure what has happened"
	fi
}
