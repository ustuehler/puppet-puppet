# Manage a section in the main Puppet configuration file (usually
# /etc/puppet/puppet.conf).
#
# == Parameters
#
# - params: hash of key/value pairs for parameters in this section
# - order: alphanumeric value used to determine the order of fragments
#
define puppet::config::section($params, $order = 20)
{
	include puppet::config

	file_fragment { "puppet::config::section($name)":
		path => $puppet::config::path,
		content => template("puppet/puppet.conf.section"),
		order => $order
	}
}
