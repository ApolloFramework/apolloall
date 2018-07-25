shareroot=`dirname ${BASH_SOURCE}`
fullshareroot=`(cd $shareroot; pwd -P)`
export APOLLO_ROOT=`dirname ${fullshareroot}`
export SPACK_ROOT=$APOLLO_ROOT/spack
PATH=$SPACK_ROOT/bin:${PATH}
alias spackinit=". $SPACK_ROOT/share/spack/setup-env.sh"
# It seems that setup-env should initialized modules but it doesn't
alias spackmodinit=". `spack location -i environment-modules`/Modules/init/bash"
