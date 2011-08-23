# Manage the "puppetd" service on OpenBSD.
class puppet::agent::service::openbsd
{
	openbsd::service { puppetd:
		enable => true,
		ensure => running
	}
}
