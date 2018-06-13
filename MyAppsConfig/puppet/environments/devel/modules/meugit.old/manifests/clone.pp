class meugit::clone ($repo, $username='root') {

    $group = $username

    group { $username:
        ensure  => present,
#        gid     => 2000,
    }

    user { $username:
        ensure  => present,
        gid     => $group,
        require => Group[$group],
        uid     => 2000,
        home    => "/home/${username}",
        shell   => "/bin/bash",
        managehome  => true,
    }

    file { "/home/${username}/sistemas" :
        ensure  => directory,
        group   => $group,
        owner   => $username,
        mode    => 0755,
    }

    file { "/home/${username}":
        ensure  => directory,
        group   => $group,
        owner   => $username,
        mode    => 0700,
    }

    vcsrepo { "/home/${username}/${repo}":
        ensure   => latest,
        owner    => $username,
        group    => $group,
        provider => git,
        require  => [ Package["git"] ],
        source   => "http://github.com/quirinobytes/${repo}.git",
        revision => 'master',
    }
}
