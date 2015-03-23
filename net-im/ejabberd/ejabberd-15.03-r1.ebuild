EAPI=5

inherit eutils multilib pam ssl-cert systemd

DESCRIPTION="The Erlang Jabber Daemon"
HOMEPAGE="http://www.ejabberd.im/ https://github.com/processone/ejabberd/"
SRC_URI="http://www.process-one.net/downloads/${PN}/${PV}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ia64 ppc ~sparc x86"
EJABBERD_MODULES="mod_irc"
IUSE="captcha debug elixir ldap mysql odbc pam pgsql tools +web zlib ${EJABBERD_MODULES}"

DEPEND=">=net-im/jabber-base-0.01
	>=dev-libs/expat-1.95
	>=dev-libs/libyaml-0.1.4
	>=dev-lang/erlang-15.2.3.1[ssl]
  elixir? ( >=dev-lang/elixir-1.0.3 )
	odbc? ( dev-db/unixODBC )
	ldap? ( =net-nds/openldap-2* )
	>=dev-libs/openssl-0.9.8e
	captcha? ( media-gfx/imagemagick[truetype,png] )
	zlib? ( >=sys-libs/zlib-1.2.3 )"
RDEPEND="${DEPEND}
	>=sys-apps/shadow-4.1.4.2-r3
	pam? ( virtual/pam )"

S=${WORKDIR}/${P}

# paths in net-im/jabber-base
JABBER_ETC="${EPREFIX}/etc/jabber"
JABBER_SPOOL="${EPREFIX}/var/spool/jabber"
JABBER_LOG="${EPREFIX}/var/log/jabber"
JABBER_DOC="${EPREFIX}/usr/share/doc/${P}"
# home folder for jabber user
JABBER_HOME="${EPREFIX}/var/lib/jabber"

src_prepare() {
	# don't install release notes (we'll do this manually)
	sed '/install .* [.][.]\/doc\/[*][.]txt $(DOCDIR)/d' -i Makefile.in || die
	# Set correct paths
	sed -e "/^EJABBERDDIR[[:space:]]*=/{s:ejabberd:${P}:}" \
		-e "/^ETCDIR[[:space:]]*=/{s:@sysconfdir@/ejabberd:${JABBER_ETC}:}" \
		-e "/^LOGDIR[[:space:]]*=/{s:@localstatedir@/log/ejabberd:${JABBER_LOG}:}" \
		-e "/^SPOOLDIR[[:space:]]*=/{s:@localstatedir@/lib/ejabberd:${JABBER_SPOOL}:}" \
		-i Makefile.in || die
	sed -e "/EJABBERDDIR=/{s:ejabberd:${P}:}" \
		-e "s|\(ETC_DIR=\){{sysconfdir}}.*|\1${JABBER_ETC}|" \
		-e "s|\(LOGS_DIR=\){{localstatedir}}.*|\1${JABBER_LOG}|" \
		-e "s|\(SPOOL_DIR=\){{localstatedir}}.*|\1${JABBER_SPOOL}|" \
		-i ejabberdctl.template || die

	# Set shell, so it'll work even in case jabber user have no shell
	# This is gentoo specific I guess since other distributions may have
	# ejabberd user with reall shell, while we share this user among different
	# jabberd implementations.
	sed '/^HOME/aSHELL=/bin/sh' -i ejabberdctl.template || die
	sed '/^export HOME/aexport SHELL' -i ejabberdctl.template || die

	#sed -e "s:/share/doc/ejabberd/:${JABBER_DOC}:" -i web/ejabberd_web_admin.erl

	# fix up the ssl cert paths in ejabberd.cfg to use our cert
	sed -e "s:/path/to/ssl.pem:/etc/ssl/ejabberd/server.pem:g" \
		-i ejabberd.yml.example || die "Failed sed ejabberd.yml.example (changing ssl patch)"

	# correct path to captcha script in default ejabberd.cfg
	sed -e 's|\(captcha_cmd:[[:space:]]*"\).\+"|\1/usr/'$(get_libdir)'/erlang/lib/'${P}'/priv/bin/captcha.sh"}|' \
		-i ejabberd.yml.example || die "Failed sed ejabberd.yml.example (changing captcha script)"

	# disable mod_irc in ejabberd.cfg
	if ! use mod_irc; then
		sed -e "s/mod_irc:/## mod_irc:/" \
			-i ejabberd.yml.example || die "Failed sed ejabberd.yml.example (disable mod_irc)"
	fi
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${P}/html" \
		--libdir="${EPREFIX}/usr/$(get_libdir)/erlang/lib/" \
		$(use_enable elixir) \
    $(use_enable mysql) \
		$(use_enable pam) \
		$(use_enable ldap eldap) \
		$(use_enable odbc) \
		$(use_enable pgsql) \
    $(use_enable tools) \
    $(use_enable web) \
		$(use_enable zlib ejabberd_zlib) \
		--enable-user=jabber
}

src_compile() {
	emake $(use debug && echo debug=true ejabberd_debug=true)
}

src_install() {
	default

	# Pam helper module permissions
	# http://www.process-one.net/docs/ejabberd/guide_en.html
	if use pam; then
		pamd_mimic_system xmpp auth account || die "Cannot create pam.d file"
		fowners root:jabber "/usr/$(get_libdir)/erlang/lib/${P}/priv/bin/epam"
		fperms 4750 "/usr/$(get_libdir)/erlang/lib/${P}/priv/bin/epam"
	fi

	newinitd "${FILESDIR}"/${PN}-3.initd ${PN}
	newconfd "${FILESDIR}"/${PN}-3.confd ${PN}
	systemd_dounit "${FILESDIR}"/${PN}.service
	systemd_dotmpfilesd "${FILESDIR}"/${PN}.tmpfiles.conf

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${PN}.logrotate ${PN}
	
	keepdir "${JABBER_HOME}"
	fowners jabber:jabber "${JABBER_HOME}"
  
  # use system elixir if enabled
  if use elixir; then
    rm -f -- "${D}${EPREFIX}/usr/bin/elixir"
    rm -f -- "${D}${EPREFIX}/usr/bin/iex"
    rm -f -- "${D}${EPREFIX}/usr/bin/mix"
  fi
}

pkg_postinst() {
	# give an home to jabber user
	usermod -d "${JABBER_HOME}" jabber

	if [[ -z ${REPLACING_VERSIONS} ]] ; then
		elog "For configuration instructions, please see"
		elog "/usr/share/doc/${P}/html/guide.html, or the online version at"
		elog "http://www.process-one.net/en/ejabberd/docs/guide_en/"

		if ! use web ; then
			ewarn
			ewarn "The web USE flag is off, this has disabled the web admin interface."
			ewarn
		fi

		local i ctlcfg new_ctlcfg
		i=0
		ctlcfg=${EROOT}/etc/jabber/ejabberdctl.cfg
		while :; do
			new_ctlcfg=$(printf "${EROOT}/etc/jabber/._cfg%04d_ejabberdctl.cfg" ${i})
			[[ ! -e ${new_ctlcfg} ]] && break
			ctlcfg=${new_ctlcfg}
			((i++))
		done

		ewarn
		ewarn "Updating ${ctlcfg} (debug: ${new_ctlcfg})"
		sed -e "/#ERLANG_NODE=/aERLANG_NODE=$EJABBERD_NODE" "${ctlcfg}" > "${new_ctlcfg}" || die

		if [[ -e ${EROOT}/var/run/jabber/.erlang.cookie ]]; then
			ewarn "Moving .erlang.cookie..."
			if [[ -e ${EROOT}/var/spool/jabber/.erlang.cookie ]]; then
				mv -v "${EROOT}"/var/spool/jabber/.erlang.cookie{,bak}
			fi
			mv -v "${EROOT}"/var/{run/jabber,spool/jabber}/.erlang.cookie
		fi
		ewarn
		ewarn "We'll try to handle upgrade automagically but, please, do your"
		ewarn "own checks and do not forget to run 'etc-update'!"
		ewarn "PLEASE! Run 'etc-update' now!"
	fi

	SSL_ORGANIZATION="${SSL_ORGANIZATION:-Ejabberd XMPP Server}"
	install_cert /etc/ssl/ejabberd/server
	# Fix ssl cert permissions bug #369809
	chown root:jabber "${EROOT}/etc/ssl/ejabberd/server.pem"
	chmod 0440 "${EROOT}/etc/ssl/ejabberd/server.pem"
	if [[ -e ${EROOT}/etc/jabber/ssl.pem ]]; then
		ewarn
		ewarn "The location of SSL certificates has changed. If you are"
		ewarn "upgrading from ${CATEGORY}/${PN}-2.0.5* or earlier  you might"
		ewarn "want to move your old certificates from /etc/jabber into"
		ewarn "/etc/ssl/ejabberd/, update config files and"
		ewarn "rm /etc/jabber/ssl.pem to avoid this message."
		ewarn
	fi
}
