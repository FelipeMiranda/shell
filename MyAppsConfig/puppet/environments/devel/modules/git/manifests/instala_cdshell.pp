class git::instala_cdshell () {

	exec{'Instala_cdshell':
#          require => File["/root/shell/install.sh"],
	  command      => "bash --rcfile /root/.bashrc -c /root/shell/install.sh",
#	  command      => "install.sh",
# 	 ensure => 
#	 refreshonly => true,
#         onlyif  => '/bin/echo 0',
	 path => '/bin',
	 #path => '/root/shell',
}


}
