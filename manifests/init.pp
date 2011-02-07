import 'classes/*.pp'
import 'defines/*.pp'

# Currently only sets some class variables to describe the running
# Puppet instance, like $puppet::vardir (which currently comes from
# a custom fact).
#
# XXX: In 2.6, Puppet config variables are available in manifests
# according to James Turnbull.
#
# Links:
# * http://groups.google.com/group/puppet-users/browse_thread/thread/ce70669c17c43ea9
#
# =CONFIGURATION
#
# These global variables can be set on a node level or in any scope
# before including the puppet class. Normally all of these variables
# are auto-detected correctly by custom facts provided by this module.
#
# $puppet_bindir:: Where Puppet user commands are installed.
# $puppet_manifest:: Runtime value of the 'manifest' configuration variable.
# $puppet_modulepath:: Runtime value of the 'modulepath' configuration variable.
# $puppet_vardir:: Runtime value of the 'vardir' configuration variable.
#
# See the following section for a list of class variables which may be
# affected by the above configuration variables.
#
# =CLASS VARIABLES
#
# These variables can be referenced using their qualified name (e.g.
# "$puppet::vardir") after including the puppet class.
#
# $manifest:: The entry-point manifest for puppetmasterd.
# $modulepath:: The search path for modules as a colon-separated list
#               of directories.
# $moduledatadir:: A directory where modules can store their data.  Each
#                  module should create their own subdirectory there to
#                  avoid conflicts.  The module's data directory should be
#                  given the same name as the module.
# $puppetdoc:: Full path to the puppetdoc(1) command.
# $specsdir:: Where the puppet::module_spec() define stores RSpec files.
# $vardir:: Where Puppet stores dynamic and growing data.
class puppet {
  $manifest = $puppet_manifest
  $modulepath = $puppet_modulepath

  if ! $vardir {
    if ! $puppet_vardir {
      fail("unable to determine \$vardir (puppet_vardir fact missing?)")
    }
    $vardir = $puppet_vardir
  }

  $puppetdoc = "$puppet_bindir/puppetdoc"

  $specsdir = "$vardir/specs"

  $moduledatadir = "$vardir/moduledata"

  file { $moduledatadir:
    ensure => directory,
    owner => root,
    group => 0,
    mode => 755
  }
}
