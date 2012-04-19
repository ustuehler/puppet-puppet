# Manage the Puppet configuration file(s).
class puppet::config
{
	include puppet

	$path = "$puppet::confdir/puppet.conf"

	file_concat { $path:
		owner => root,
		group => 0,
		mode => 444,
		require => Class[puppet]
	}

	file_fragment { $name:
		path => $path,
		content => "# MANAGED BY PUPPET\n",
		order => 00
	}

	include puppet::config::main
}
