# Manage the [master] section in the Puppet configuration file.
class puppet::config::master()
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
		order => 12
	}
}
