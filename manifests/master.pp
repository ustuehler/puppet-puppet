# Manage the Puppet master service.  Including this class does not
# manage the Puppet agent service.  However useful that may be, you
# can have a Puppet master that does not run a Puppet agent (or that
# doesn't manage the agent aspects of the Puppet configuration.)
class puppet::master
{
	include puppet::config::master
}
