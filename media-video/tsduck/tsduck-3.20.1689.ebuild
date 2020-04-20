# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit versionator

DESCRIPTION="TSDuck, The MPEG Transport Stream Toolkit"
HOMEPAGE="https://tsduck.io/"
MY_PV=$(replace_version_separator 2 -)
SRC_URI="https://github.com/tsduck/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	emake NOTEST=1 NODTAPI=1 NOCURL=1 NOPCSC=1 NOSRT=1 NOTELETEXT=1
}

src_install() {
	emake NOTEST=1 NODTAPI=1 NOCURL=1 NOPCSC=1 NOSRT=1 NOTELETEXT=1 SYSROOT="" SYSPREFIX="${D}" install
}

