# This will configure the node as a Puppet master using Passenger.
#
# == Parameters
#
# - rackdir: Directory that contains the config.rb file for Passenger.
# - ssldir: Directory where Puppet keeps its SSL certificates.
#
class puppet::master::passenger($rackdir, $ssldir)
{
	# Install Apache + Passenger with SSL support.
	#require apache2
	require apache2::mod_passenger
	require apache2::mod_ssl

	# Configure the SSL client verification directives in the
	# [master] section of puppet.conf because the default values
	# in Puppet don't match with what Apache's mod_ssl provides.
	puppet::config::option {
	    ssl_client_header:
		section => master,
		value => SSL_CLIENT_S_DN,
		before => Service[apache2];

	    ssl_client_verify_header:
		section => master,
		value => SSL_CLIENT_VERIFY,
		before => Service[apache2];
	}

	# Create the <VirtualHost> configuration for Passenger.
	apache2::site { puppetmaster:
		content => template("puppet/apache2-puppetmaster.conf")
	}
}
