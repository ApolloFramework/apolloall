#!/bin/tcsh -f 
set called=($_)
if ( "$called" != "" ) then  ### called by source 
   set script_fn=$called[2]
else                         ### called by direct excution of the script
   set script_fn=$0
endif
set script_dir=`dirname $script_fn`
# The fact that subshell doesn't seem to work is annoying
#set full_script_dir=`(cd $script_dir; pwd -P)`
cd $script_dir
set full_script_dir=`pwd -P`
cd -
set aroot=`dirname ${full_script_dir}`
setenv APOLLO_ROOT $aroot
setenv SPACK_ROOT  $APOLLO_ROOT/spack
setenv PATH $SPACK_ROOT/bin:${PATH}
source $SPACK_ROOT/share/spack/setup-env.csh

# See this:
# https://unix.stackexchange.com/questions/4650/determining-path-to-sourced-shell-script
# http://tipsarea.com/2013/04/11/how-to-get-the-script-path-name-in-cshtcsh/
