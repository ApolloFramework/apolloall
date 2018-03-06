#!/bin/bash
#
#------------------------------------------------------------------
#####
## Method to print out general and script specific options
#
extReposUsage() {
  # Get options
  set -- "$@"
  OPTIND=1
  cat >&2 <<EOF
Usage: $0 [options]
EOF

  cat >&2 <<EOF
EXTERNALREPO USAGE 
  -h ................ print help
  -a ................ Get or update everything
  -c ................ Get camellia
  -C ................ Get camellia2
  -t ................ Get theaceae
  -T ................ Get Trilinos
  -s ................ Get spack
  -S ................ Get scimake
  -L ................ List all of the repos including those not covered
 
EOF
}

#
# Method for processing the arguments
#
processExtreposArgs() {
  case "$1" in
    c) GET_CAMELLIA=true;;
    C) GET_CAMELLIA2=true;;
    s) GET_SPACK=true;;
    S) GET_SCIMAKE=true;;
    t) GET_THEACEAE=true;;
    T) GET_TRILINOS=true;;
    a) GET_CAMELLIA=true
       GET_CAMELLIA2=true
       GET_SPACK=true
       GET_SCIMAKE=true
       GET_THEACEAE=true
       GET_TRILINOS=true
       ;;
    L) LISTALL=true;;
    h) extReposUsage 0; exit 0;;
   \?) extReposUsage 1; exit 0;;
    *)  # To take care of any extra args
      if test -n "$OPTARG"; then
        eval $arg=\"$OPTARG\"
      else
        eval $arg=found
      fi
      ;;
  esac
}

GET_CAMELLIA=false
GET_CAMELLIA2=false
GET_SPACK=false
GET_SCIMAKE=false
GET_THEACEAE=false
GET_TRILINOS=false
LISTALL=false
EXTREPOS_ARGS="acChLsStT"
while getopts "$EXTREPOS_ARGS" arg; do
  processExtreposArgs $arg
done

github=github.com
bitbucket=bitbucket.org
apollo=${github}/ApolloFramework

SCRIPT_DIR=`dirname $0`

#####
##  Function which clones if localname doesn't exist and just updates if it does
#
getRepoUser() {
  local reponame=${2}
  case $USER in
  kruger)
     if test "${reponame}" == "${bitbucket}"; then
        repouser=krugers
     else
        repouser=kruger   # github
     fi
     ;;
  esac
  echo $repouser
  return 
}

#####
##  Function which clones if localname doesn't exist and just updates if it does
#
cloneGitRepo() {
  local webloc=${1}
  local reponame=${2}
  local localname=${3}
  repouser=`getRepoUser $webloc`
  if test -d $localname; then
    cd $localname
    git pull
    cd -
  else
    git clone https://${repouser}@${webloc}/${reponame} $localname
  fi
}

addExtraUpstream() {
  local webloc=${1}
  local reponame=${2}
  local localname=${3}
  local upstreamname=${4}
  local branchname=${5}
  repouser=`getRepoUser $webloc`
  cd $localname
  local configline=`grep remote .git/config | grep $upstreamname\"`
  if test -z "$configline"; then
    git remote add ${upstreamname} https://${repouser}@${webloc}/${reponame}
    git fetch ${upstreamname}
    if test -n "${branchname}"; then
       git checkout $branchname
    fi
  fi
  cd -
}

### 
##  Clone or update petsc as well as set up the upstream
#
# This is the old version that we keep anyway
if $GET_CAMELLIA; then
  cloneGitRepo $apollo "Camellia" "camellia"
fi
# Main upstream will be Nate's version, but add our version as well
if $GET_CAMELLIA2; then
  cloneGitRepo $apollo "camellia2" "camellia2"
  addExtraUpstream $bitbucket nateroberts/camellia camellia2 upstream ""
fi
# This is the repo for our preferred build system
if $GET_SPACK; then
  cloneGitRepo $apollo spack spack
  addExtraUpstream $github "spack/spack" "spack" "upstream" ""
fi
if $GET_SCIMAKE; then
  cloneGitRepo $apollo scimake scimake
fi
# This is the repo for the test cases
if $GET_TRILINOS; then
  cloneGitRepo $apollo "Trilinos" "trilinos"
  addExtraUpstream $github "trilinos/Trilinos" "trilinos" "upstream" ""
fi
# This is the repo for the test cases
if $GET_THEACEAE; then
  cloneGitRepo $apollo "theaceae" "theaceae"
fi



if $LISTALL; then
  cat >&2 <<SHEOF

CAMELLIA (-c option):
 git clone https://${apollo}/Camellia camellia

CAMELLIA (-C option):
 git clone https://${apollo}/camellia2 camellia2
 git remote add upstream https://${bitbucket}/nateroberts/camellia 

THEACEAE (-t option):
 git clone https://${apollo}/theaceae theaceae

SPACK (-s option):
 git clone https://${apollo}/spack spack
 git remote add upstream https://${github}/spack/spack

TRILINOS (-T option):
 git clone https://${apollo}/Trilinos trilinos
 git remote add upstream https://${github}/trilinos/Trilinos

SHEOF

fi
