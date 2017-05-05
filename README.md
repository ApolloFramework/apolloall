# apolloall
Main repository for the Apollo framework
apolloall provides a convenient way for cloning and building the framework and dependencies.
We use git submodules to manage the dependencies. A guide for how to use submodule is available at https://git-scm.com/book/en/v2/Git-Tools-Submodules
In principle, you should be able to build the framework with the following command on Mac OSX:
/mkapolloall.sh -a -j <# of cores> -b <PATH_TO_BUILD_LOCATION> -k <PATH_TO_INSTALL_LOCATION> -i <<ATH_TO_INSTALL_LOCATION> -m darwin.clangcxx11 -C -I -F -y -o -E USE_MPI=mpich -E SUPERLU_DIST5_BUILDS=par camellia
