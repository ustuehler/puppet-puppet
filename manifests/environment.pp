# Manage an [environment] section in puppet.conf.
define puppet::environment($basedir)
{
	puppet::config::environment { $name:
		basedir => $basedir
	}
}
