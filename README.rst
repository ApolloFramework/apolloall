apolloall
==========

apolloall is a container for all of individual git repositories that make up the
actual project.  Currently these are:

  + `theaceae <https://github.com/ApolloFramework/theaceae>`_ :
      - Main goal of the Apollo Framework: A set of test cases for evaluating
        discretization schemes across a wide range of physics cases
      - *Generally build/work from repository*
  + `Camellia2 <https://github.com/ApolloFramework/Camellia2>`_ :
      - A Petrov-Galerkin toolkit used to evaluate the different methods
      - *Generally build/work from repository*
      - `Main camellia site <https://bitbucket.org/nateroberts/camellia>`_ :
  + `spack <https://github.com/ApolloFramework/spack>`_ 
      - A meta-build system for easily building the dependency tree for the
        project within a single system
      - *Generally build/work from repository with apollo branch*
      - `Main spack site <https://spack.io>`_
  + `Trilinos <https://github.com/ApolloFramework/Trilinos>`_ :
      - Mathematics library that provides much of the core infrastructure for
        Camellia
      - *Generally build/work from tarball*
      - `Main trilinos site <https://trilinos.org>`_
  + Moab: 
      - Meshing library that provides interface to mesh readers and tools
      - *Generally build/work from tarball*
      - `Main moab site <http://sigma.mcs.anl.gov/moab-library/>`_


Installation of theaceae, Camellia, and dependencies
----------------------------------------------------

To check out the repository from the command line::

      git clone https://github.com/ApolloFramework/apolloall apolloall


To get repositories we need, type from within the apolloall directory::

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

The `-a` option only checks out the immediate repositories needed.  It is also
possible to clone trilinos and moab as well.

Once the external repositories are checked out, then configuration can occur by
sourcing the appropriate shell files::

      source share/apollo.sh   # Bash users
      source share/apollo.csh  # tcsh users

We use `spack` to manage the build dependency process.
To tell spack to get the package information for apollo::

      cat $APOLLO_ROOT/share/repos.yaml >> ~/.spack/repos.yaml

It is useful to have `spack` bootstrap itself especially for some of the python
dependencies needed::

      spack bootstrap

To make sure the compilers are configured, this is a simple package to build and
install::

      spack install libelf

If it doesn't work, then you may need to configure
`$HOME/.spack/compilers.yaml`.  This shows the current compilers::

      spack compilers

This can help configure the `compilers.yaml` file for you::

      spack compiler find

To install Theacae along with Camellia and all it's dependencies::

      spack install theaceae

This will automatically build and install Camellia with the appropriate trilinos
builds.  The camellia build command that it is equivalent to is::

      spack install camellia@apollo2

which downloads and installs the master branch of camellia in the `apolloall` repository. 

The master branch of camellia from Nate Roberts can be installed using the command::

      spack install camellia@nates_master

If you want to install you own local version of camellia using the diy command::

      spack diy camellia@<version> -d path/to/camellia

Or you can navigate to the Camellia root directory and run::

      spack diy camellia@<version>

This does not work that well so instead we have been using
`$APOLLO_ROOT/share/make-config.sh`.  You can run this script
from anywhere on your file system and serves as a more convenient way of
switching to the normal edit/build development workflow cycle.

Todo::
  + Spack diy doesn't work that well debug
