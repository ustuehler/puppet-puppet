# This class is included by puppet::master::bootstrap on Debian
# and sets up a production Puppet master with Passenger.
class puppet::master::bootstrap::debian()
{
	# Verify that this Debian release is supported.
	case $operatingsystemrelease {
	    /^6\./: {
		# Squeeze 6.0.2 has been tested.
	    }

	    default: {
		fail("$operatingsystemrelease is currently unsupportee")
	    }
	}

	# Install the Puppet master package and ensure that the
	# standalone WEBrick service is not running.
	#
	# The "puppet" package is expected to be already installed
	# and includes all the Ruby code for the master, but the
	# "puppetmaster" package provides the rack configuration
	# which is required for a Passenger setup.
	package { puppetmaster:
		ensure => present
	}->service { puppetmaster:
		ensure => stopped,
		hasstatus => true
	}

	# Configure the SSL client verification directives in the
	# [master] section of puppet.conf because the default values
	# in Puppet don't match with what Apache's mod_ssl provides.
	puppet::config::option {
	    ssl_client_header:
		section => master,
		value => SSL_CLIENT_S_DN,
		require => Package[puppetmaster],
		before => Service[apache2];

	    ssl_client_verify_header:
		section => master,
		value => SSL_CLIENT_VERIFY,
		require => Package[puppetmaster],
		before => Service[apache2];
	}

	# Install Apache + Passenger and other required modules.
	require apache2::mod_passenger
	require apache2::mod_ssl

	# Create the <VirtualHost> configuration for Passenger.
	$ssldir = "/var/lib/puppet/ssl"
	$rackdir = "/usr/share/puppet/rack/puppetmasterd"
	apache2::site { puppetmaster:
		content => template("puppet/apache2-puppetmaster.conf")
	}
}
