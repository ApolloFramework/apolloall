
Additional spack notes
-----------------------

More information on spack itself can be here:
   http://spack.readthedocs.io/en/latest/getting_started.html

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

Actually it is best to put this into packages.yaml::

      packages:
        all:
          providers:
            mpi: [mpich, openmpi]
        hdf5:
          variants: +cxx+hl+zlib
        trilinos:
          variants: +intrepid+intrepid2+shards+hdf5+zlib

Personal spack notes 
--------------------

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

 For creating meshes, gmsh is great but isn't spack enabled.  Use your favorite
 OS package manager for these.  For Mac, this is::

  brew install gmsh --with-fltk

