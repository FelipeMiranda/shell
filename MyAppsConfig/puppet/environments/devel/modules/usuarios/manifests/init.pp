class usuarios{

	group {
		"www":
		    ensure  => present,
		    gid     => 1000
	}

	user { 'www':
	  ensure     => present,
	  uid        => '1000',
	  gid        => '1000',
	  shell      => '/bin/false',
	  home       => '/var/www/'
	}



}
