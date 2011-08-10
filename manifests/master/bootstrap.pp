# Bootstrap a Puppet master on this node.
#
# The need for this special class arises from the fact that this
# class must be compatible with the "puppet apply" command when
# no other Puppet master is already available.  We thus avoid to
# use any features that would require an existing Puppet server.
#
# == Parameters
#
# This class currently takes no parameters.
#
# == Examples
#
# For the most simple use case it is enough to just do a basic
# installation of Puppet and then run the following command from
# a shell as root:
#
#  echo include puppet::master::bootstrap | puppet apply
#
# Most sites will probably customize the bootstrap process a
# little and will define a wrapper class that looks something
# like this:
#
#  class site::puppet::master::bootstrap
#  {
#          class { "::puppet::master::bootstrap":
#                  # Optionally pass some parameters.
#          }
#
#          # Define other resources to complete the specific
#          # bootstrap procedure for your own site...
#  }
#
class puppet::master::bootstrap()
{
	$os = inline_template("<%= operatingsystem.downcase %>")
	require "${name}::${os}"
}
