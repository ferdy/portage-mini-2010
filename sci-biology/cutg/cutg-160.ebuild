# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/cutg/cutg-160.ebuild,v 1.3 2010/03/07 20:50:00 jlec Exp $

EAPI="3"

DESCRIPTION="Codon usage tables calculated from GenBank"
LICENSE="public-domain"
HOMEPAGE="http://www.kazusa.or.jp/codon/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
# Minimal build keeps only the indexed files (if applicable) and the
# documentation. The non-indexed database is not installed.
IUSE="emboss minimal"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris"

DEPEND="emboss? ( sci-biology/emboss )"
RDEPEND="${DEPEND}"

src_compile() {
	if use emboss; then
		mkdir CODONS
		echo
		einfo "Indexing CUTG for usage with EMBOSS."
		EMBOSS_DATA="." cutgextract -auto -directory "${S}" || die \
			"Indexing CUTG failed."
		echo
	fi
}

src_install() {
	if ! use minimal; then
		mkdir -p "${ED}"usr/share/${PN}
		mv *.codon *.spsum "${ED}"/usr/share/${PN} || die \
			"Installing raw CUTG database failed."
	fi
	dodoc README CODON_LABEL SPSUM_LABEL || die \
			"Failed to install documentation."
	if use emboss; then
		mkdir -p "${ED}"/usr/share/EMBOSS/data/CODONS
		cd CODONS
		for file in *; do
			mv ${file} "${ED}"/usr/share/EMBOSS/data/CODONS || die \
				"Installing the EMBOSS-indexed database failed."
		done
	fi
}
