EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )

inherit cmake-utils

DESCRIPTION=""
HOMEPAGE="https://github.com/cutelyst/cutelyst"
KEYWORDS="x86 amd64"
SRC_URI="https://github.com/cutelyst/cutelyst/archive/v${PV}.tar.gz -> cutelyst-${PV}.tar.gz"
IUSE="docs +test +uwsgi"

LICENSE="GPL-2"
SLOT="0"

RDEPEND=">=dev-qt/qtcore-5.6
	>=dev-qt/qtnetwork-5.6
	dev-libs/jemalloc
	uwsgi? ( www-servers/uwsgi )
	docs? ( app-doc/doxygen )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${PV}"

src_configure() {
	local mycmakeargs=()
	if ! use test; then
		mycmakeargs+=("-DBUILD_TESTS=FALSE")
	fi
	cmake-utils_src_configure
}
