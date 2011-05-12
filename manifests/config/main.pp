# Manage the [main] section in the Puppet configuration file.
class puppet::config::main()
{
	include puppet

	puppet::config::section { main:
		params => {
		    logdir => $puppet::logdir,
		    vardir => $puppet::vardir,
		    ssldir => $puppet::ssldir,
		    rundir => $puppet::rundir,
		    factpath => $puppet::factpath,
		    templatedir => $puppet::templatedir,
		    pluginsync => true,
		    report => true
		},
		order => 10
	}
}
