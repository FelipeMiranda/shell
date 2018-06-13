    define apache::vhost ($port, $docroot, $servername = $title, $vhost_name = '*') {
      include apache # contains Package['httpd'] and Service['httpd']
#      include apache::params # contains common config settings
      $vhost_dir = $apache::params::vhost_dir
      
	

	file { "${vhost_dir}/${servername}.conf":
        content => template('/etc/puppet/environments/devel/modules/apache/manifests/vhost-default.conf.erb'),
          # This template can access all of the parameters and variables from above.
        owner   => 'www',
        group   => 'www',
        mode    => '644',
        require => Package['httpd'],
        notify  => Service['httpd'],
      }
    }
