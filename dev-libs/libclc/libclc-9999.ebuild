# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

EGIT_REPO_URI="https://github.com/pol51/${PN}.git"
EGIT_BRANCH="3.4"

inherit base python-any-r1 git-r3

DESCRIPTION="OpenCL C library"
HOMEPAGE="http://libclc.llvm.org/"

LICENSE="|| ( MIT BSD )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=sys-devel/clang-3.4
	>=sys-devel/llvm-3.4"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}"

src_configure() {
	./configure.py \
		--with-llvm-config="${EPREFIX}/usr/bin/llvm-config" \
		--prefix="${EPREFIX}/usr"
}
