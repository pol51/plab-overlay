# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils git-2

DESCRIPTION="Colobot (Colonize with Bots) is an educational real-time strategy video game featuring 3D graphics"
HOMEPAGE="http://colobot.info/"
SRC_URI=""

EGIT_REPO_URI="https://github.com/colobot/colobot.git"
EGIT_PROJECT="colobot"
EGIT_BRANCH="master"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

IUSE=""

DEPEND="
  media-libs/sdl-image
  media-libs/openal
  dev-libs/boost
  dev-util/cmake
"
RDEPEND="
  ${DEPEND}
  games-strategy/colobot-data
"

S="${WORKDIR}/${PN}"

src_prepare() {
  epatch ${FILESDIR}/use_dynamic_boost.patch
  epatch ${FILESDIR}/fix_man_dependency.patch
}

src_configure() {
  cd ${S}
  cmake -DCMAKE_BUILD_TYPE=Release -DOPENAL_SOUND=1 .
}
