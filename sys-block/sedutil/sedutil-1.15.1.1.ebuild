# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="The Drive Trust Alliance Self Encrypting Drive Utility"
HOMEPAGE="https://github.com/Drive-Trust-Alliance/sedutil"

EGIT_REPO_URI="https://github.com/badicsalex/sedutil.git"
EGIT_BRANCH="s3-sleep-support"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"

src_prepare() {
	default
	
	sed 's: -Werror: :g' \
		-i configure.ac \
		-i Makefile.am || die
	
	eautoreconf
}
