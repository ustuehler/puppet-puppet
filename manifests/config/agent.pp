# Manage the [agent] section in the Puppet configuration file.
class puppet::config::agent($environment = $environment)
{
	puppet::config::section { agent:
		params => {
		    environment => $environment
		},
		order => 11
	}
}
