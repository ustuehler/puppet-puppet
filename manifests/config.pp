# Manage the Puppet configuration file(s).
class puppet::config
{
	include puppet

	$path = "$puppet::confdir/puppet.conf"

	concat { $path:
		owner => root,
		group => 0,
		mode => 444,
		require => Class[puppet]
	}

	concat::fragment { $name:
		target => $path,
		content => "# MANAGED BY PUPPET\n",
		order => 00
	}

	include puppet::config::main
}
