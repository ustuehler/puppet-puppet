# Download the Puppet Dashboard web application and install it from the
# distribution tarball (not as a package).
#
# This class should optionally be included on a Puppet master. It will
# listen and respond to HTTP requests on port 3000.
#
# == Parameters
#
# - version: Version of the Dashboard tarball to download. The $version
#   and $srcdist parameters are related as of version 1.0.4 and need to
#   be updated together.  It is unfortunate that the name of the source
#   directory inside the tarball contains a commit hash.
#
# == Usage
#
# Include the class, optionally turn on reporting on Puppet agents and
# put the following in /etc/puppet/puppet.conf on the master (or something
# similar, as long as "http" is in the list):
#
#   [master]
#   reports = http
#
# If you also want to use Puppet Dashboard as an external node classifier
# you have to add this to /etc/puppet/puppet.conf (on the master):
#
#   [master]
#   external_nodes = /var/lib/puppet-dashboard/bin/external_node
#   node_terminus = exec
#
class puppet::dashboard($path = "/", $port = 3000, $basedir = undef,
    $download_mirror = extlookup("puppet::dashboard::download_mirror",
    "http://puppetlabs.com/downloads/dashboard"), $version =
    extlookup("${name}::version", "1.0.4"), $srcdist = extlookup(
    "${name}::srcdist", "puppetlabs-puppet-dashboard-071acf4"),
    $rails_env = "production")
{
	# Store the final values of some parameters.
	class { params:
		path => $path,
		port => $port,
		basedir => $basedir ? {
		    undef => $operatingsystem ? {
			Debian => "/var/lib/puppet-dashboard",
			default => "/var/puppet-dashboard"
		    },
		    default => $basedir
		},
		rails_env => $rails_env
	}

	$distname = "puppet-dashboard-$version"
	$download_url = "${download_mirror}/$distname.tar.gz"

	include mysql::server
	include ruby::mysql


	group { puppet-dashboard:
		ensure => present
	}->user { puppet-dashboard:
		ensure => present,
		gid => puppet-dashboard,
		home => $params::basedir,
		managehome => false
	}->wget::file { "${params::basedir}-${version}.tgz":
		source => $download_url
	}->file { "/var/lib/${srcdist}":
		ensure => directory,
		owner => puppet-dashboard,
		group => puppet-dashboard,
		mode => 755
	}->exec { "/usr/bin/env tar -xzf /var/lib/${distname}.tgz -C /var/lib":
		creates => "/var/lib/${srcdist}/config/database.yml.example",
		user => puppet-dashboard,
		group => puppet-dashboard
	}->file { $params::basedir:
		ensure => $srcdist
	}->file { "/var/lib/puppet-dashboard/config/database.yml":
		ensure => present,
		content => template("bsdx/puppet/dashboard/config/database.yml"),
		owner => puppet-dashboard,
		group => puppet-dashboard,
		mode => 444
	}->exec { "$params::rake db:create db:migrate":
		cwd => $params::basedir,
		creates => "/var/lib/mysql/dashboard",
		user => puppet-dashboard,
		group => puppet-dashboard,
		require => Class['mysql::server', 'ruby::mysql', 'ruby::rake']
	}->cron { puppet-dashboard-maintenance:
		user => puppet-dashboard,
		command => "cd $params::basedir && $params::rake reports:prune upto=1 unit=day db:raw:optimize",
		hour => 9,
		minute => 0
	}->file { "/etc/init.d/puppet-dashboard":
		ensure => present,
		content => template("bsdx/puppet/dashboard/initscript"),
		owner => root,
		group => root,
		mode => 555,
		notify => Service[puppet-dashboard]
	}->service { puppet-dashboard:
		enable => true,
		ensure => running,
		hasstatus => true
	}->file { "${params::basedir}/bin/external_node":
		content => template("bsdx/puppet/dashboard/external_node"),
		owner => root,
		group => root,
		mode => 555
	}->file { "${params::basedir}/lib/tasks/classesgroups_exists.rake":
		ensure => present,
		source => "puppet:///modules/puppet/dashboard/classesgroups_exists.rake",
		owner => root,
		group => root,
		mode => 444
	}
}
