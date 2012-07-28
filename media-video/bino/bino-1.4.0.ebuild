EAPI=4
inherit eutils git-2

DESCRIPTION="free 3d video player"
HOMEPAGE="http://bino3d.org"

EGIT_REPO_URI="git://git.savannah.nongnu.org/bino.git"
EGIT_PROJECT="${PN}"

if [[ ${PV} = "9999" ]]; then
  EGIT_BRANCH="master"
else
  EGIT_COMMIT="bino-${PV}"
fi

SRC_URI=""
SLOT="0"

KEYWORDS="amd64"

IUSE="-lirc"

RDEPEND="
  media-video/ffmpeg
  media-libs/libass
  media-libs/openal
  media-libs/glew
  x11-libs/qt-core
  x11-libs/qt-gui
  x11-libs/qt-opengl
  lirc? ( app-misc/lirc )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_configure() {
  autoreconf -i
  
  local binoconf="--without-equalizer"
  
  if use lirc; then
    binoconf += " --with-liblircclient"
  else
    binoconf += " --without-liblircclient"
  fi
  
  econf ${binoconf}
}

src_install() {
  emake DESTDIR="${D}" install
}
