# Manage the Puppet agent service running as a daemon.
class puppet::agent::service
{
	$class = inline_template("${name}::<%= operatingsystem.downcase %>")
	require $class
}
