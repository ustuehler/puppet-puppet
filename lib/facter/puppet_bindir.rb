require 'rbconfig'

Facter.add("puppet_bindir") do
  default_paths = [
    '/usr/bin',
    '/usr/sbin',
    '/usr/local/bin',
    '/usr/local/sbin',
    Config::CONFIG['bindir'],
    Config::CONFIG['sbindir'],
  ]

  setcode do
    bindir = ''
    (ENV['PATH'].split(':') + default_paths).each do |dir|
      filename = File.join(dir, 'puppetdoc')
      if File.exists?(filename)
        bindir = dir
        break
      end
    end
    bindir
  end
end
