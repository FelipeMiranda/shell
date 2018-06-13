class cdshell::clone ($repo,$username=root){

    vcsrepo { "/${username}/${repo}":
        ensure   => latest,
        owner    => $username,
        group    => $group,
        provider => git,
        require  => [ Package["git"] ],
        source   => "git@github.com:quirinobytes/${repo}.git",
        revision => 'master',
    }

}
