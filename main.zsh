#! /usr/bin/env zsh

###############################################################################
## > Entry point                                                             ##
##   This is the main entry point of the updater project.                    ##
##   It will find out what distro the system is running, and invoke the      ##
##   right updater to do the job.                                            ##
###############################################################################

#>>> Now in technicolor:
autoload colors ; colors

# Find out the system's distro:
__DISTRO__=""

if hash lsb_release 2> /dev/null; then
  __DISTRO__=$(lsb_release --id | sed -e "s,.*[ \t],,g")

else
  __DISTRO__=$(grep "ID" /etc/os-release | sed "s,.*=,,g")
fi

# Be sure it's all lowercase:
__DISTRO__=$(print "$__DISTRO__" | tr '[:upper:]' '[:lower:]')

# cd to the script directory, or something really wrong may happen when using
# source:
EXEC_LOCATION=$(which $0)
DIR_LOCATION=""
# If it isn't a symlink, cd into its directory:
if [[ ! -L $EXEC_LOCATION ]]; then
  DIR_LOCATION="$(dirname $EXEC_LOCATION)"
# If it's a symlink, find its destination and cd there:
else
  DIR_LOCATION="$(ls -l $EXEC_LOCATION)"
  DIR_LOCATION="$(print $DIR_LOCATION | awk '{print $11}')"
  DIR_LOCATION="$(dirname $DIR_LOCATION)"
fi
cd $DIR_LOCATION

# Arch Linux:
if [[ "arch" == $__DISTRO__ ]]; then
  source ./lib/arch.zsource

# Debian and derivates:
elif [[ "debian" == $__DISTRO__ ]]; then
  source ./lib/debian.zsource

# Unsupported distro:
else
  print -n "$fg[red]The following distro is not supported:$fg[default] "
  print "$__DISTRO__"
fi

# Run the updater:
update_distro "Updater" $@
return $?

# Unset variables:
unset __DISTRO__ EXEC_LOCATION DIR_LOCATION

