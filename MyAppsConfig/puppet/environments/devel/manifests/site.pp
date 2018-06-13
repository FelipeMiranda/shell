node 'dev1.intranet' {}
node 'dev2.intranet' {}


#node 'default'{}

#include ambiente-dev

include git
include helloworld
include usuarios

#class {'instalar_repositorio': repo => '' }    # PRECISAR CONSERTAR

#class { 'apache':default_vhost => false, }

#include apache
#include apache::mod::php
#include apache::mod::proxy_http

#class { 'apache::mod::prefork':
#  startservers => '12',
#}
 
package { 'php' :
  ensure => present ,
}

class { 'apache':
  default_vhost => false,
  mpm_module      => 'prefork',
}
include apache::mod::php

#apache::mod { 'php5': }
# Listen on port 80 and 81; required because the following vhosts
# are not declared with a port parameter.
apache::listen { '80': }
#apache::listen { '81': }

apache::vhost {'manzano':
  ip       => '192.168.200.128',
  docroot  => '/var/www/manzano',
  ip_based => true,
}

# IP-based vhosts
apache::vhost {'mydev':
	ip       => '0.0.0.0',
	docroot  => '/var/www/webserver',
	ip_based => true,
	directories  => [
    	{ path           => '/var/www/webserver/',
			options => ['Indexes','FollowSymLinks','MultiViews'],
		},
		{ path           => '/var/www/webserver/proxy',
			options => ['Indexes','FollowSymLinks','MultiViews'],
			allow_override => ['AuthConfig', 'Indexes'],
		},

	],
}

apache::vhost {'antidrone.com.br':
  ip       => '192.168.200.128',
  docroot  => '/var/www/webserver',
  ip_based => true,
  directories  => [
    	{ path           => '/var/www/webserver/',
			options => ['Indexes','FollowSymLinks','MultiViews'],
			allow_override => ['AuthConfig', 'Indexes'],
		},
		{ path           => '/var/www/webserver/arquivos',
			options => ['Indexes','FollowSymLinks','MultiViews'],
			allow_override => ['AuthConfig', 'Indexes'],
		},

	],

}

apache::vhost {'bluemoney.superati.com.br':
  ip       => '192.168.200.128',
  docroot  => '/var/www/bluemoney',
  ip_based => true,
  directories  => [
		{ path           => '/var/www/bluemoney',
			options => ['Indexes','FollowSymLinks','MultiViews'],
			allow_override => ['AuthConfig', 'Indexes'],
		},

	],
}
apache::vhost {'superati.antidrone.com.br':
  ip       => '192.168.200.128',
  docroot  => '/var/www/superati',
  ip_based => true,
  directories  => [
		{ path           => '/var/www/superati',
			options => ['Indexes','FollowSymLinks','MultiViews'],
			allow_override => ['AuthConfig', 'Indexes'],
		},

	],
}
apache::vhost {'www.superati.com.br':
  ip       => '192.168.200.128',
  docroot  => '/var/www/superati',
  ip_based => true,
  directories  => [
		{ path           => '/var/www/superati',
			options => ['Indexes','FollowSymLinks','MultiViews'],
			allow_override => ['AuthConfig', 'Indexes'],
		},

	],
}



apache::vhost {'www.supera.ti':
  ip       => '192.168.200.128',
  docroot  => '/var/www/superati',
  ip_based => true,
  directories  => [
		{ path           => '/var/www/superati',
			options => ['Indexes','FollowSymLinks','MultiViews'],
			allow_override => ['AuthConfig', 'Indexes'],
		},

	],
}



#class { 'helloworld': }
class { 'helloworld::motd': env => 'DEV' }
class { 'private_keys': }

$pkg_list = [ "mc", "automake", "gcc", "mongodb", "mongodb-server", "nodejs","tig","mariadb","dialog"]
	package { $pkg_list: ensure => "installed" }


#nginx::resource::vhost { 'kibana.myhost.com':
#  listen_port => 800,
#  proxy       => 'http://localhost:5601',
#}

#git::clone { 'repo' : value => 'shell', 'username' : value => 'root' } # essa classe top clona o repositorio.
class { git::clone: repo => 'shell' }
class { git::instala_cdshell: }

class {workspace::clone: repo => 'workspace'}

class {codigofonte::clone:
	path => '/root/webserver',
	repo => 'codigo-fonte',
}
#class {help::clone: repo => 'help'} # Necessário desenvolver ainda.

git::config { 'user.name':   value => 'Rafael Quirino', }
git::config { 'user.email':  value => 'quirinobytes@gmail.com',}

#class { git::install: command => '/root/shell/install.sh' }
