# Manage the [agent] section in the Puppet configuration file.
class puppet::config::agent($environment = $environment)
{
	puppet::config::section { agent:
		params => {
		    environment => $environment,
		    pluginsync => true,
		    report => true
		},
		order => 11
	}
}
