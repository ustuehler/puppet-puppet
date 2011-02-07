Facter.add("puppet_modulepath") do
  setcode do
    Puppet['modulepath']
  end
end
