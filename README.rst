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


Initial setup and configuration
-------------------------------

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
for future use.  This can be done by sourcing the appropriate shell files::

      source share/apollo.sh   # Bash users
      source share/apollo.csh  # tcsh users

These initialization files: 

  + define the environment variables `APOLLO_ROOT` and `SPACK_ROOT` 
  + put the spack into the path
  + create two aliases `spackinit` and `spackmodinit` that provide advanced spack initialization
    (but can be slow to load so is not done as part of login configuration
    files but rather as aliases)
  + Adds the `module` command that spack built above to the configuration which
    is useful for using spack-built python utilities

The scripts can be sourced from your `~/.bashrc` or `~/.tcshrc` files.

We use `spack` to handle building the dependencies for the Apollo project.
It is useful to have `spack` bootstrap itself especially for some of the python
dependencies needed.  From the apollo directory (tcsh users may need to type
`rehash` to find spack within the path)::

      spack bootstrap

To make sure the compilers are configured, this is a simple package to build and
install::

      spack install libelf

If it doesn't work, then you may need to configure
`$HOME/.spack/compilers.yaml`.  This shows the current compilers::

      spack compilers

This can help configure the `compilers.yaml` file for you::

      spack compiler find

Finally, to tell spack to get the package information for apollo::

      cat share/repos.yaml >> ~/.spack/repos.yaml

which relies on the `APOLLO_ROOT` environment variable.  With spack configured,
you can also initialize spack usage::

      spackinit
      spackmodinit

These aliases can take a bit of time to run which is why they are aliases and
not executed from the `~/.bashrc` or `~/.tcshrc` files.

Installation of theaceae, Camellia, and dependencies
----------------------------------------------------

To install Theacae along with Camellia and all it's dependencies::

      spack install theaceae

This will automatically build and install Camellia with the appropriate trilinos
builds.  The spack installation command that it is equivalent to installing the
right version of camellia is::

      spack install camellia@apollo2

which downloads and installs the master branch of camellia in the `apolloall` repository. 

The master branch of camellia from Nate Roberts can be installed using the command::

      spack install camellia@nates_master

If you want to install you own local version of camellia using the diy command::

      spack diy camellia@<version> -d path/to/camellia

Or you can navigate to the Camellia root directory and run::

      spack diy camellia@<version>

This does not work that well so instead we have been using::

       $APOLLO_ROOT/share/camellia-mkconfig.sh
       $APOLLO_ROOT/share/theaceae-mkconfig.sh

to create build directories for development and testing.  The scripts can be run
from anywhere on your file system and serves as a more convenient way of
switching to the normal edit/build development workflow cycle.

The documentation for the Apollo project is all done with the 
`Sphinx documentation: <http://www.sphinx-doc.org>`_ system.
It uses python scripts to convert the ReStructured Text files into html.
To get the right PYTHONPATH configured, first make sure you have run the
`spackmodinit` alias and then::

      spack load py-sphinx
      spack load py-packaging

One is now be ready to build theaceae including the documentation

