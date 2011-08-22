# Manage the [agent] section in the Puppet configuration file.
class puppet::agent::config($environment = $environment)
{
	puppet::config::section { agent:
		params => {
		    environment => $environment,
		    pluginsync => true,
		    report => true,
		    server => $servername
		},
		order => 11
	}
}
