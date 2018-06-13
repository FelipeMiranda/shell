class helloworld::motd {

    file { '/etc/motd':
    owner  => 'root',
    group  => 'root',
    mode    => '0644',
    content => "Oi TREYCE, seja bem vinda !\n",
    }

 }
