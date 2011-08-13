class puppet::master::install
{
	#require inline_template("${name}::<%= operatingsystem.downcase %>")
	require ruby::activerecord
	require ruby::sqlite3
}
