define puppet::dashboard::nodeclass($ensure = present)
{
	require puppet::dashboard
	require puppet::dashboard::params

	$rake = $puppet::dashboard::params::rake

	exec { "puppet::dashboard::nodeclass($name)":
		cwd => $puppet::dashboard::params::basedir,
		command => "$rake nodeclass:add name='$name'",
		unless => "$rake nodeclass:exists name='$name'" 
	}
}
