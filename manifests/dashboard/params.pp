# Empty container class for Puppet Dashboard parameters.
class puppet::dashboard::params($path, $port, $basedir, $rails_env)
{
	include ruby::rake

	$rake = "${ruby::rake::rake} RAILS_ENV='${rails_env}'"
}
