# Manage options in /etc/puppet/puppet.conf.
define puppet::config::option($section, $value)
{
	# TODO: implement resource type to manage puppet.conf in Ruby

	include puppet::config

	# XXX: repeating [$section] unnecessarily here
	concat::fragment { "puppet::config::option($name)":
		target => $puppet::config::path,
		content => "\n[${section}]\n${name}=${value}\n"
	}
}
