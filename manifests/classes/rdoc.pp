# Generates an HTML RDoc hierarchy describing the manifests that are
# in 'manifestdir' and 'modulepath'.
#
# =CONFIGURATION
#
# $puppet_rdoc_outputdir:: Specifies the directory where to output the
#                          RDoc documentation. (required)
#
# =BUGS AND CAVEATS
#
# The documentation directory must not exist before and will be
# created only once.  Thereafter the documentation is only regenerated
# if the output directory is deleted.
#
# The rdoc documentation generator may not work in all versions of
# Puppet (see issue 4798).
#
# =SEE ALSO
#
# * http://projects.puppetlabs.com/issues/4798
class puppet::rdoc
{
  include puppet

  if ! $puppet_rdoc_outputdir {
    fail("No output directory for RDoc documentation specified")
  }

  exec { 'puppet::rdoc/puppetdoc':
    command => "$puppet::puppetdoc --all --mode rdoc --outputdir '$puppet_rdoc_outputdir' --modulepath '$puppet::modulepath' --manifest='$puppet::manifest'",
    creates => $puppet_rdoc_outputdir,
    logoutput => on_failure
  }
}
