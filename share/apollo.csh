setenv APOLLO_ROOT $SCRATCH/dgFramework/apolloall
setenv SPACK_ROOT  $APOLLO_ROOT/spack
setenv PATH $SPACK_ROOT/bin:${PATH}
alias spackinit 'source $SPACK_ROOT/share/spack/setup-env.csh'
# It seems that setup-env should initialized modules but it doesn't
alias spackmodinit 'source `spack location -i environment-modules`/init/tcsh'

# See this on why we have to manually configurate this file
# https://unix.stackexchange.com/questions/4650/determining-path-to-sourced-shell-script
# http://tipsarea.com/2013/04/11/how-to-get-the-script-path-name-in-cshtcsh/
