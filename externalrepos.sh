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
  -a ................ Get or update all important repos: theaceae, camellia2, spack, scimake
  -c ................ Get camellia
  -C ................ Get camellia2
  -t ................ Get theaceae
  -T ................ Get Trilinos (optional since default is to use spack provided)
  -s ................ Get spack
  -S ................ Get scimake
  -I ................ Get apolloframework.github.io
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
    I) GET_IO=true;;
    s) GET_SPACK=true;;
    S) GET_SCIMAKE=true;;
    t) GET_THEACEAE=true;;
    T) GET_TRILINOS=true;;
    a) GET_CAMELLIA2=true
       GET_SPACK=true
       GET_SCIMAKE=true
       GET_THEACEAE=true
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
EXTREPOS_ARGS="acChILsStT"
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
  ehowell)
     if test "${reponame}" == "${bitbucket}"; then
        repouser=ehowell
     else
        repouser=echowell   # github
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
  echo "camellia"
  cloneGitRepo $apollo "Camellia" "camellia"
fi
# Main upstream will be Nate's version, but add our version as well
if $GET_CAMELLIA2; then
  echo "camellia2"
  cloneGitRepo $apollo "camellia2" "camellia2"
  addExtraUpstream $bitbucket nateroberts/camellia camellia2 upstream ""
fi
# This is the repo for our preferred build system
# We do not do much development of spack itself, so default is github
# and apollo is added as another remote with the name of apollo
if $GET_SPACK; then
  echo "spack"
  cloneGitRepo $github "spack/spack" "spack"
  addExtraUpstream $apollo "spack" "spack" "apollo" ""
fi
if $GET_SCIMAKE; then
  echo "scimake"
  cloneGitRepo $apollo scimake scimake
fi
# This is the repo for the test cases
if $GET_TRILINOS; then
  echo "trilinos"
  cloneGitRepo $apollo "Trilinos" "trilinos"
  addExtraUpstream $github "trilinos/Trilinos" "trilinos" "upstream" ""
fi
# This is the repo for the test cases
if $GET_THEACEAE; then
  echo "theaceae"
  cloneGitRepo $apollo "theaceae" "theaceae"
fi
if $GET_IO; then
  echo "github.io"
  cloneGitRepo $apollo "apolloframework.github.io" "apolloframework.github.io"
fi



if $LISTALL; then
  cat >&2 <<SHEOF

CAMELLIA (-c option): (Not downloaded with -a)
 git clone https://${apollo}/Camellia camellia

CAMELLIA (-C option):
 git clone https://${apollo}/camellia2 camellia2
 git remote add upstream https://${bitbucket}/nateroberts/camellia 

THEACEAE (-t option):
 git clone https://${apollo}/theaceae theaceae

SCIMAKE (-S option):
 git clone https://${apollo}/scimake scimake

SPACK (-s option):
 git clone https://${apollo}/spack spack
 git remote add upstream https://${github}/spack/spack

TRILINOS (-T option):  (Not downloaded with -a)
 git clone https://${apollo}/Trilinos trilinos
 git remote add upstream https://${github}/trilinos/Trilinos

APOLLOFRAMEWORK.GITHUB.IO:  (Not downloaded with -a)
 git clone https://${apollo}/apolloframework.github.io
SHEOF

fi
