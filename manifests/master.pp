# Manage the Puppet master service.  Including this class does not
# manage the Puppet agent service.  However useful that may be, you
# can have a Puppet master that does not run a Puppet agent (or that
# doesn't manage the agent aspects of the Puppet configuration.)
#
# == Parameters
#
# - servicename: Passed on to the config class, which see.
#
class puppet::master($servicename)
{
	class { config:
		servicename => $servicename
	}

	require config, install
}
