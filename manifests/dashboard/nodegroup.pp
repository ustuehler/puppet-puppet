define puppet::dashboard::nodegroup($ensure = present, $classes = '')
{
	require puppet::dashboard
	require puppet::dashboard::params

	$rake = $puppet::dashboard::params::rake

	exec { "puppet::dashboard::nodegroup($name)":
		cwd => $puppet::dashboard::params::basedir,
		command => "$rake nodegroup:add name='$name' classes='$classes'",
		unless => "$rake nodegroup:exists name='$name'" 
	}
}
