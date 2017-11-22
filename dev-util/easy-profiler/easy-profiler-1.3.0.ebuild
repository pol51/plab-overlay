# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Lightweight profiler library for c++"
HOMEPAGE="https://github.com/yse/easy_profiler"
EGIT_REPO_URI="https://github.com/yse/easy_profiler.git"
EGIT_COMMIT="v${PV}"

LICENSE="MIT"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE=""

RDEPEND="
	dev-qt/designer:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtsql:5
	dev-qt/qtwebkit:5"
DEPEND="${RDEPEND}"

