EAPI=4
inherit eutils git-2

DESCRIPTION="zsh pol's config"

EGIT_REPO_URI="git@vps.labedan.fr:zsh.git"
EGIT_PROJECT="zsh"
EGIT_BRANCH="master"

SRC_URI=""
SLOT="0"

KEYWORDS="~amd64"

RDEPEND="app-shells/zsh-completion"
DEPEND=""

S="${WORKDIR}/${PN}"

src_install() {
  ebegin "Copy pol's zsh config..."
  insinto /etc/zsh
  doins -r *
  eend $? || "ERROR: cannot install zsh config"
}
