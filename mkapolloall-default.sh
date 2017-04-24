#!/bin/bash
#
# Build and install in places following our conventions for LCFs,
# clusters, and workstations.  Logic in bilder/mkall-default.sh
#
# $Id$
######################################################################

# Get lcf variables
mydir=`dirname $0`
mydir=${mydir:-"."}
mydir=`(cd $mydir; pwd -P)`
# Where to find configuration info
BILDER_CONFDIR=$mydir/bilderconf
# Subdir under INSTALL_ROOTDIR where this package is installed
PROJECT_INSTSUBDIR=apollo
source $mydir/bilder/mkall-default.sh

# Build the package
runBilderCmd
res=$?
exit $res

