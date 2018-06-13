class apache {

    package { 'apache':
        ensure => $package_ensure,
        name   => 'httpd',
      }
}



