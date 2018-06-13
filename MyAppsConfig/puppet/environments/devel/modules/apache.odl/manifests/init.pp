class apache {


	package { 'httpd':
        	ensure => $package_ensure,
		name   => 'httpd',
	}

	service { "httpd":
		ensure  => running,
		start   => "/usr/sbin/apachectl start",
		stop    => "/usr/sbin/apachectl stop",
		pattern => "/usr/sbin/httpd",
		enable => true,		#Liga na inicializacao.
	        
	}


}



