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
		    factpath => '$vardir/lib/facter', # XXX
		    templatedir => '$confdir/templates', # XXX
		},
		order => 10
	}
}
