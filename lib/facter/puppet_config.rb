Facter.add("puppet_manifest") do
  setcode do
    Puppet['manifest']
  end
end

Facter.add("puppet_modulepath") do
  setcode do
    Puppet['modulepath']
  end
end

Facter.add("puppet_vardir") do
  setcode do
    Puppet['vardir']
  end
end

Facter.add("puppet_ssldir") do
  setcode do
    Puppet['ssldir']
  end
end
