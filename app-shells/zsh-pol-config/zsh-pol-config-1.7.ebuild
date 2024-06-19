EAPI=8

DESCRIPTION="zsh pol's config"

SRC_URI=""
SLOT="0"

KEYWORDS="amd64"

RDEPEND="
  app-shells/zsh-completions
  app-shells/gentoo-zsh-completions
"
DEPEND=""

S="${WORKDIR}"

src_install() {
  ebegin "Copy pol's zsh config..."
  	insinto /etc/zsh
  	doins -r ${FILESDIR}/*
  eend $? || "ERROR: cannot install zsh config"
}
