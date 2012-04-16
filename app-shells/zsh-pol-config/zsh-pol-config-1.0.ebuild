EAPI=4
inherit eutils

DESCRIPTION="zsh pol's config"

SRC_URI=""
SLOT="0"

KEYWORDS="amd64"

RDEPEND="app-shells/zsh-completion"
DEPEND=""

src_install() {
  ebegin "Copy pol's zsh config..."
  insinto /etc/zsh
  doins -r ${FILESDIR}/*
  eend $? || "ERROR: cannot install zsh config"
}
