# Specify this by hand and then source from your ~/.tcshrc file
setenv APOLLO_ROOT `echo NEED TO SET APOLLO_ROOT`
setenv SPACK_ROOT  $APOLLO_ROOT/spack
setenv PATH $SPACK_ROOT/bin:${PATH}
source $SPACK_ROOT/share/spack/setup-env.csh
