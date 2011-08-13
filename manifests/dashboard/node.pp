define puppet::dashboard::node($ensure = present, classes='', groups='')
{
	require puppet::dashboard
	require puppet::dashboard::params

	$rake = $puppet::dashboard::params::rake

	case $ensure {
	    absent: {
		$task = "node:del name='$name'"
		$test = "! $rake node:list | awk '\$1==\"$name\"{exit 1}'"
	    }
	    present: {
		$task = "node:add name='$name' classes='$classes' groups='$groups'"
		$test = "$rake node:list | awk '\$1==\"$name\"{exit 1}'"
	    }
	}

	exec { "puppet::dashboard::node($name)":
		cwd => $puppet::dashboard::params::basedir,
		command => "$rake $task",
		onlyif => $test
	}
}
