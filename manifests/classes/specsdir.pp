class puppet::specsdir {
  include puppet
  include root

  file { $puppet::specsdir:
    ensure => directory,
    owner => root,
    group => $root::group,
    mode => 744
  }
}
