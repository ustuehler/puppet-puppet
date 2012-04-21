class puppet::master::install
{
	#require inline_template("${name}::<%= operatingsystem.downcase %>")
	require ruby::active_record
	require ruby::sqlite3
}
