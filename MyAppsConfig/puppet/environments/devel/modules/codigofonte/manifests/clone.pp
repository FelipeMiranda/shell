class codigofonte::clone ($repo, $path,$username=root){

    vcsrepo { "$path/$repo":
        ensure   => latest,
        owner    => $username,
        group    => $group,
        provider => git,
        require  => [ Package["git"] ],
        source   => "git@github.com:quirinobytes/${repo}.git",
        revision => 'master',
    }

}
