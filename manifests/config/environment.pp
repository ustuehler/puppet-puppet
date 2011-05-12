# Define a Puppet configuration fragment for an environment.
define puppet::config::environment($confdir,
    $modulepath = "$confdir/modules",
    $manifestdir = "$confdir/manifests",
    $manifest = "$manifestdir/site.pp")
{
	puppet::config::section { $name:
		params => {
		    modulepath => $modulepath,
		    manifestdir => $manifestdir,
		    manifest => $manifest,
		}
	}
}
