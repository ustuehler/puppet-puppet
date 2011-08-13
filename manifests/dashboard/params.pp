# Empty container class for Puppet Dashboard parameters.
class puppet::dashboard::params($path, $port, $vardir, $rails_env)
{
	include ruby::rake

	$rake = "${ruby::rake::rake} RAILS_ENV='${rails_env}'"
	$basedir = "$vardir/puppet-dashboard"
}
