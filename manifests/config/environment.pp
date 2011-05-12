# Manage a Puppet configuration fragment for an environment.
define puppet::config::environment($basedir,
    $modulepath = "$basedir/modules",
    $manifestdir = "$basedir/manifests",
    # XXX: $manifest = "$manifestdir/site.pp" does not work
    # because $manifestdir expands to ""
    $manifest = undef
) {
	puppet::config::section { $name:
		params => {
		    modulepath => $modulepath,
		    manifestdir => $manifestdir,
		    # XXX: see parameter list
		    manifest => $manifest ? {
			undef => "$manifestdir/site.pp",
			default => $manifest
		    },
		}
	}
}
