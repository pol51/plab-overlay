# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.3

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Crossbar.io - Polyglot application router"
HOMEPAGE="http://crossbar.io/"
SRC_URI="https://pypi.python.org/packages/source/c/crossbar/${P}.zip"

LICENSE="AGPL-3"
KEYWORDS="~amd64"
SLOT="0"
IUSE="manhole msgpack postgres system tls"

DEPEND="dev-python/setuptools"
RDEPEND=">=dev-python/autobahn-0.8.9[twisted]
	>=dev-python/jinja-2.7.2
	>=dev-python/netaddr-0.7.11
	>=dev-python/setuptools-2.2
	>=dev-python/twisted-core-13.2
	>=net-zope/zope-interface-3.6.0
	dev-python/setuptools
	manhole? ( >=dev-python/pyasn1-0.1.7 )
	manhole? ( >=dev-python/pycrypto-2.6.1 )
	msgpack? ( >=dev-python/msgpack-python-0.4.2 )
	postgres? ( >=dev-python/psycopg-2.5.1 )
	system? ( >=dev-python/psutil-2.1.1 )
	system? ( >=dev-python/pyinotify-0.9.4 )
	system? ( >=dev-python/setproctitle-1.1.8 )
	tls? ( >=dev-python/cryptography-0.4 )
	tls? ( >=dev-python/pyopenssl-0.14 )
	tls? ( dev-python/pyasn1 )
	tls? ( dev-python/pyasn1-modules )
	tls? ( dev-python/service-identity )"

