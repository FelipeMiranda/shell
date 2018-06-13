class git::clone ($repo, $username='root') {
    vcsrepo { "/${username}/${repo}":
        ensure   => latest,
        #ensure   => present,
        owner    => $username,
        group    => $group,
        provider => git,
        require  => [ Package["git"] ],
        source   => "git@github.com:quirinobytes/${repo}.git",
        revision => 'master',
    }
}
