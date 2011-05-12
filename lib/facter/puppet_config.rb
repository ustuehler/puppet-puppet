['confdir',
 'manifest',
 'manifestdir',
 'templatedir',
 'modulepath',
 'factpath',
 'vardir',
 'ssldir',
 'logdir',
 'rundir',
].each do |param|
  Facter.add("puppet_#{param}") do
    setcode do
      Puppet[param]
    end
  end
end
