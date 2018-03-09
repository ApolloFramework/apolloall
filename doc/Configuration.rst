
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

      cp $APOLLO_ROOT/share/repos.yaml ~/.spack

More information on spack itself can be here:
   http://spack.readthedocs.io/en/latest/getting_started.html



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

