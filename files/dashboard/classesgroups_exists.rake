namespace :nodeclass do
  desc 'Check if a node class exists'
  task :exists => :environment do
    if ENV['name']
      name = ENV['name']
    else
      puts 'Must specify class name (name=<class>).'
      exit 1
    end

    if NodeClass.find_by_name(name)
      puts 'Class exists'
      exit 0
    end

    puts 'Class does not exist'
    exit 1
  end
end

namespace :nodegroup do
  desc 'Check if a node group exists'
  task :exists => :environment do
    if ENV['name']
      name = ENV['name']
    else
      puts 'Must specify group name (name=<group>).'
      exit 1
    end

    if NodeGroup.find_by_name(name)
      puts 'Group exists'
      exit 0
    end

    puts 'Group does not exist'
    exit 1
  end
end
