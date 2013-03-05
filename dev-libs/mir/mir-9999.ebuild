# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit bzr

DESCRIPTION="A next generation display server"
HOMEPAGE="https://wiki.ubuntu.com/MirSpec"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"

KEYWORDS=""

EBZR_REPO_URI="lp:mir"

IUSE=""

S=${WORKDIR}/${P}
BUILD_DIR=${S}/build

src_prepare() {
  epatch "${FILESDIR}/use_default_gcc.patch"

  mkdir ${BUILD_DIR}
  cd ${BUILD_DIR}
  cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr ..
}

src_compile() {
  cmake --build ${BUILD_DIR}
}

src_install() {
  cd ${BUILD_DIR}
  emake install
}
