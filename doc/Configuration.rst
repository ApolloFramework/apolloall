
Getting all of the external repositories
-----------------------------------------

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


Configuring the Apollo project
-----------------------------------------

Once the external repositories are checked out, then configuration can occur by
sourcing the appropriate shell files::

      source share/apollo.sh   # Bash users
      source share/apollo.csh  # tcsh users

The `apollo.sh` can be sourced from your `$HOME/.bashrc` file. Tcsh users should
modify `share/apollo_source.csh` and use this to source.

The main actions of this sourcing is:

   + Define `APOLLO_ROOT` environment variable
   + Define `SPACK_ROOT` environment variable
   + Add `SPACK_ROOT/bin` to the path
   + Source the appropriate spack configuration files


Further preparations for using spack
-----------------------------------------

Install a simple package with spack just to get going::

      spack install libelf

To tell spack to get the package information for apollo::

      cat $APOLLO_ROOT/share/repos.yaml >> ~/.spack/repos.yaml


More information on spack itself can be here:
   http://spack.readthedocs.io/en/latest/getting_started.html


Install packages we need::

      spack install trilinos+intrepid+intrepid2+hdf5^zlib
      spack install moab

The more complicated trilinos install is to insure that moab and trilinos
are built with the same dependency tree.

Create views::

      spack view --verbose symlink -i $SCRATCH/apolloview  trilinos 
      spack view --verbose symlink $SCRATCH/apolloview  moab

The  -i above is to ignore conflicts and there are conflicts between superlu and
SuiteSparse.

The above do not work very well if you have multiple installed.  So you need to
need to use::

      spack find -lv moab
      spack find -lv trilinos
      spack find -dlv moab
      spack find -dlv trilinos

To find the versions that work.  For me, I could then::

      spack view --verbose symlink $SCRATCH/apolloview moab^/oajmavs

Could also just do this::

      spack find -p trilinos@12.12.1

And then put it into the config script::

        -DTrilinos_ROOT_DIR:PATH='/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/trilinos-12.12.1-g4bhxtdbxr53qzzfuvgtpwhulkleaz73' \


Actually it is best to put this into packages.yaml::

      packages:
        all:
          providers:
            mpi: [mpich, openmpi]
        hdf5:
          variants: +cxx+hl+zlib
        trilinos:
          variants: +intrepid+intrepid2+shards+hdf5+zlib

My spack notes
-----------------------------------------

I personally put my builds and caches into a
"SCRATCH" directory so that I can avoid backing
them up for my laptop.  So I have these lines in my 
``$HOME/.spack/config.yaml``::

  build_stage:
    - /scr_gabrielle/kruger/spacksoftware/var/spack/stage

  source_cache: /scr_gabrielle/kruger/spacksoftware/var/spack/cache


For the builds, spack will link recent builds in 
``$spack/var/spack/stage`` to this cache.  I like having
a shortcut to access these build directories::

  ln -sf spack/var/spack/stage builds

Spack 


On mac
brew install gmsh --with-fltk

