#!/bin/sh
#
# Copy this shell script to a new machine and run it there as root to install
# a reasonably recent Puppet client in accordance with best practices for the
# target operating system.
#

# Option -m makes sure that in addition to the Puppet client, the
# Puppet master is also installed *and running*.
mflag=false

while getopts m opt
do
	case $opt in
	m)	mflag=true;;
	?)	printf "Usage: %s [-m]\n" $0 >&2
		exit 2;;
	esac
done

exit

# Usage: errx code message
errx()
{
	echo "ERROR: $2" >&2
	exit "$1"
}

# Usage: info message
info()
{
	echo "$1"
}

# Set up the PATH environment variable.
system=`uname -s` || exit $?
case "$system" in
OpenBSD)
	PATH="$PATH:/usr/local/sbin"
	export PATH
	;;
SunOS)
	PATH="$PATH:/usr/ruby/1.8/sbin"
	export PATH
	;;
esac

# TODO: Step 1: Look for an existing puppetd executable and check its version;
# exit if the installed puppetd is "new enough" (whatever that means - the
# client version must be compatible with the Puppet master, so we need the
# Puppet master version in that case).
executable="`which puppetd 2>/dev/null`"
if [ -x "$executable" ]; then
	echo "puppetd is $executable"
	exit 0
fi

# TODO: Step 2: Invoke an OS-specific installation routine.
case `uname -s` in
SunOS) # TODO
	;;

OpenBSD) # TODO
	if [ -f /etc/pkg.conf ] || [ -n "$PKG_PATH" ]; then
		info "Installing ruby-puppet package"
		pkg_add ruby-puppet || exit $?
	else
		errx 1 "Neither /etc/pkg.conf exists nor is \$PKG_PATH set"
	fi

	info "Replacing stock /etc/puppet/puppet.conf (saved as puppet.conf.inst)"
	mv -f /etc/puppet/puppet.conf /etc/puppet/puppet.conf.inst && \
	cat >/etc/puppet/puppet.conf <<EOF || exit $?
[puppetd]
report = true
#factsync = true
pluginsync = true

[puppetmasterd]
reports = store,rrdgraph,tagmail,log
#node_terminus = ldap
#ldapserver = culain.madstop.com
#ldapbase = dc=madstop,dc=com
EOF
	;;
esac

