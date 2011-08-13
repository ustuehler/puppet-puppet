# Manage the [master] section in the Puppet configuration file.
#
# == Parmaeters
#
# - servicename: Name of the Puppet master service (e.g. 'puppetmaster'
#   or 'apache2' when running under Passenger).
#
class puppet::master::config($servicename)
{
	puppet::config::section { master:
		params => {
		    reports => "http, store",
		    reporturl => "http://localhost/dashboard/reports",
		    external_nodes => "/var/lib/puppet-dashboard/bin/external_node",
		    node_terminus => exec,
		    autosign => true,
		    storeconfigs => true,
		    dbadapter => sqlite3
		},
		order => 12,
		notify => Service[$servicename]
	}
}
