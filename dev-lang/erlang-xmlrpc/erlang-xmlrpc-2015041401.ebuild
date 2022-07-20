EAPI="6"

inherit eutils git-r3

DESCRIPTION="Erlang xmlrpc"
HOMEPAGE="http://www.xmlrpc.org/"

EGIT_REPO_URI="https://github.com/pol51/xmlrpc.git"

if [[ ${PV} = "9999" ]]; then
  EGIT_BRANCH="master"
else
  EGIT_COMMIT="${PV}"
fi

KEYWORDS="amd64"
SLOT="0"

DEPEND="dev-lang/erlang"
RDEPEND="${DEPEND}"

src_compile() {
	emake
}

src_install() {
	insinto ${EPREFIX}/usr/$(get_libdir)/erlang/lib/xmlrpc-${PV}
	doins ebin/*
}
