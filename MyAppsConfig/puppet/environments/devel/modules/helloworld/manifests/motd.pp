class helloworld::motd ($env,$green='\e[32m',$normal='\e[0;0m') {

$ascii= generate('/bin/sh', '-c', "/usr/bin/figlet -c ${hostname}")
  
  file {'/etc/motd':
    ensure	=> file,
    path	=> '/etc/motd',
    owner	=> 'root',
    mode	=> '0644',
    content	=> template('/etc/puppet/environments/devel/modules/helloworld/manifests/motd/motd.erb'),
    before	=> Notify['motd'],
  }

  notify {'motd':
    message	=> 'MOTD has been synced!',
  }


}



#Outro Exemplo com somente o conteudo.
/*    file { '/etc/motd':
	owner  => 'root',
	group  => 'root',
	mode    => '0644',
	content => "\n Oi TREYCE, seja bem vinda !\n Você está em um ambiente: \"$green\" $env\n\n \"$normal\"",
    }
*/


