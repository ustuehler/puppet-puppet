Facter.add("puppet_manifest") do
  setcode do
    Puppet['manifest']
  end
end
