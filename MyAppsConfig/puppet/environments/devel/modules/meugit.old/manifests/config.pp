define meugit::config (
  $value,
  $key      = $name,
  $section  = undef,
  $user     = 'root',
  $scope    = 'global',
) {
  # Backwards compatibility with deprecated $section parameter.
  # (Old versions took separate $section and $key, e.g. "user" and "email".)
  if $section != undef {
    warning('Parameter `section` is deprecated, supply the full option name (e.g. "user.email") in the `key` parameter')
    $_key = "${section}.${key}"
  } else {
    $_key = $key
  }

  $git_package = $::git::package_manage ? {
    true    => Package[$::git::package_name],
    default => undef,
  }

  git_config { $title:
    key     => $_key,
    value   => $value,
    user    => $user,
    scope   => $scope,
    require => $git_package,
  }
}
