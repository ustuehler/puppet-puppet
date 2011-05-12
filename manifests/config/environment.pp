# Define a Puppet configuration fragment for an environment.
define puppet::config::environment($basedir,
    $modulepath = "$basedir/modules",
    $manifestdir = "$basedir/manifests",
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