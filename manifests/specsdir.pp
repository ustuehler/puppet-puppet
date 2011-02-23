# Create the base directory for Puppet-managed RSpec tests.
class puppet::specsdir
{
	include puppet

	file { $puppet::specsdir:
		ensure => directory,
		owner => root,
		group => 0,
		mode => 755
	}
}
