class instalar_repositorio ($repo) {

	yumrepo { "rpmforge":
	      baseurl => "http://apt.sw.be/redhat/el7/en/\$basearch/rpmforge/",
	      descr => "RPMForge Community repository",
	      enabled => 1,
	      gpgcheck => 0,
	      ensure => present,
	}

	  package { $pacote : ensure=>installed; }

}

