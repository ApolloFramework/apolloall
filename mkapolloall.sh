#!/bin/bash
#
# $Id: $
#
# For building all external packages on which the usengine depends
#
######################################################################

######################################################################
#
# Determine the projects directory.  This can be copied into other scripts
# for the sanity check.  Assumes that BILDER_NAME has been set.
# $BILDER_NAME.sh is the name of the script.
#
# The main copy is in bilder/findProjectDir.sh
#
######################################################################

findProjectDir() {
  myname=`basename "$0"`
  if test $myname = $BILDER_NAME.sh; then
# If name matches, PROJECT_DIR is my dirname.
    PROJECT_DIR=`dirname $0`
  elif test -n "$PBS_O_WORKDIR"; then
# Can I find via PBS?
    if test -f $PBS_O_WORKDIR/$BILDER_NAME.sh; then
      PROJECT_DIR=$PBS_O_WORKDIR
    else
      cat <<EOF
PBS, with PBS_O_WORKDIR = $PBS_O_WORKDIR and $PWD for the
current directory, but $PBS_O_WORKDIR does not contain
$BILDER_NAME.sh.  Under PBS, execute this in the directory
of $BILDER_NAME.sh, or set the working directory to be the
directory of $BILDER_NAME.sh
EOF
      exit 1
    fi
  else
    echo "This is not $BILDER_NAME.sh, yet not under PBS? Bailing out."
    exit 1
  fi
  PROJECT_DIR=`(cd "$PROJECT_DIR"; pwd -P)`
  if echo "$PROJECT_DIR" | grep -q ' '; then
    cat <<_
ERROR: Working directory, '$PROJECT_DIR', contains a space.
Bilder will fail.
Please remove the spaces from the directory name and then re-run.
_
    exit 1
  fi
}

######################################################################
#
# Begin program
#
######################################################################

# Name of script to look for in project dir
BILDER_NAME=mkapolloall
findProjectDir
# Where to find configuration info
export BILDER_CODIR=$PROJECT_DIR/bilder
export BILDER_CONFDIR=$PROJECT_DIR/bilderconf
# Name of package that determines whether to wait before building
WAIT_PACKAGE=apollo
# Set the installation umask
umask 007

if [ ! -d "$BILDER_CODIR" ]; then
  # Control will enter here if $BILDER_CODIR doesn't exist.
  svn co https://github.com/ApolloFramework/bilder.git/trunk $BILDER_CODIR
fi

if [ -d "$BILDER_CODIR" ]; then
  # Control will enter here if $DIRECTORY exists.
  svn up $BILDER_CODIR
fi

#
# Get all bilder methods and variables
#
source $PROJECT_DIR/bilder/bildall.sh

######################################################################
#
# Build the chain
#
######################################################################

project=${1:-"apollo"}
cmd="buildChain ${project}"
techo "$cmd"
$cmd

######################################################################
#
#  Create configuration files, email, and generally finish
#
######################################################################

createConfigFiles
installConfigFiles
finish

