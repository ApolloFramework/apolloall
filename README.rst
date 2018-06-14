apolloall
==========

apolloall is a container for all of individual git repositories that make up the
actual project.  Currently these are:

  + `theaceae`_ : https://github.com/ApolloFramework/theaceae
      - Main goal of the Apollo Framework: A set of test cases for evaluating
        discretization schemes across a wide range of physics cases
  + `Camellia`_ : https://github.com/ApolloFramework/Camellia 
      - A Petrov-Galerkin toolkit used to evaluate the different methods
  + `Camellia2`_ : https://github.com/ApolloFramework/Camellia2 
      - A Petrov-Galerkin toolkit used to evaluate the different methods
  + `Trilinos`_ : https://github.com/ApolloFramework/Trilinos 
      - Mathematics library that provides much of the core infrastructure for
        Camellia
  + `spack`_ : https://github.com/ApolloFramework/spack 
      - A meta-build system for easily building the dependency tree for the
        project within a single system


The above links point to the Apollo project forks of the respective git repositories.


Installation
==========

To check out the repository from the command line::

      git clone https://github.com/ApolloFramework/apolloall apolloall


To get all of the repositories we need, type from within the apolloall 
directory::

      ./externalrepos.sh -a

The first time this is run, it will do a `git clone`, and upon successive
invocations it will perform a `git update`.  

Options are available to `clone or update` a single repository.  To see these
options::

      ./externalrepos.sh -h

In addition to checking out the Apollo forks of these repositories,
`externalrepos.sh` also adds remotes to the upstream repositories.  To see the
essential actions taken, `externalrepos.sh` can `Show` it's actions::

      ./externalrepos.sh -S

Once the external repositories are checked out, then configuration can occur by
sourcing the appropriate shell files::

      source share/apollo.sh   # Bash users
      source share/apollo.csh  # tcsh users

To tell spack to get the package information for apollo::

      cat $APOLLO_ROOT/share/repos.yaml >> ~/.spack/repos.yaml

To install Camellia and all it's dependencies::

      spack install camellia

The spack package has instructions to install several versions of Camellia. 
The command::

      spack install camellia@apollo

Downloads and installs the master branch of camellia in the `apolloall` repository. It is equivalent to the command::

      spack install camellia

Alternatively the apolloall `camellia2` can be installed using the command::

      spack install camellia@apollo2

Finally the master branch of camellia can be installed using the command::

      spack install camellia@nates_master

Todo::
  + Fix package.py for apollo branches of camellia
  + I need a better name for the master branch of camellia
  + Create a package installer for theaceae
  + Instructions on how to use spack diy to install a local version of Camellia
