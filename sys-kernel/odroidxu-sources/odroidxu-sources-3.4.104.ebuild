# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
ETYPE="sources"

K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"

inherit kernel-2 git-2
detect_version

KEYWORDS="arm"
HOMEPAGE="https://github.com/hardkernel/linux"
IUSE="deblob"

DESCRIPTION="Linux kernel source for the ODROIDXU products"
EGIT_REPO_URI="https://github.com/hardkernel/linux.git"
EGIT_COMMIT="v${PV}"

pkg_postinst() {
        kernel-2_pkg_postinst
        einfo "For more info on this patchset, and how to report problems, see:"
        einfo "${HOMEPAGE}"
}

pkg_postrm() {
        kernel-2_pkg_postrm
}