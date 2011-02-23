define puppet::module_spec($module, $template = false) {
  include puppet
  include puppet::specsdir
  include root

  if $template {
    file { "$puppet::specsdir/${module}_$name":
      ensure => present,
      content => template("$module/specs/$name"),
      owner => root,
      group => $root::group,
      mode => 440,
      require => File[$puppet::specsdir]
    }
  } else {
    file { "$puppet::specsdir/${module}_$name":
      ensure => present,
      source => "puppet:///modules/$module/specs/$name",
      owner => root,
      group => $root::group,
      mode => 444,
      require => File[$puppet::specsdir]
    }
  }
}
