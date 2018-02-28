shareroot=`dirname ${BASH_SOURCE}`
fullshareroot=`(cd $shareroot; pwd -P)`
export APOLLO_ROOT=`dirname ${fullshareroot}`
export SPACK_ROOT=$APOLLO_ROOT/spack
PATH=$SPACK_ROOT/bin:${PATH}
source $SPACK_ROOT/share/spack/setup-env.sh
