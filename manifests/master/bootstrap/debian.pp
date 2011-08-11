# This class is included by puppet::master::bootstrap on Debian
# and sets up a production Puppet master with Passenger.
class puppet::master::bootstrap::debian()
{
	# Verify that this Debian release is supported.
	case $operatingsystemrelease {
	    /^6\./: {
		# Squeeze 6.0.2 has been tested, but needs backports to
		# get Puppet 2.7.x.
		debian::apt::source { backports:
			uri => "http://backports.debian.org/debian-backports",
			distribution => "squeeze-backports",
			components => 'main',
			before => Package[puppetmaster-passenger]
		}
	    }

	    default: {
		fail("$operatingsystemrelease is currently unsupportee")
	    }
	}

	# Install the Puppet master package for a Passenger setup.
	package { puppetmaster-passenger:
		ensure => present
	}

	# Configure the SSL client verification directives in the
	# [master] section of puppet.conf because the default values
	# in Puppet don't match with what Apache's mod_ssl provides.
	puppet::config::option {
	    ssl_client_header:
		section => master,
		value => SSL_CLIENT_S_DN,
		require => Package[puppetmaster-passenger],
		before => Service[apache2];

	    ssl_client_verify_header:
		section => master,
		value => SSL_CLIENT_VERIFY,
		require => Package[puppetmaster-passenger],
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
