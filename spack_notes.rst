

Issues
======

spack cd does not work for me.  I can't tell if it's because I've f'd something
up or whether just changing my stage dirs do not work.

bash/tcsh initialization is slow

How to get petsc


Ideas
=====

Need to enable PROJECT level overrides:
  - Currently spack defaults ($spack/etc)
  - User based

  To enable PROJECT level overrides:
    projects.yaml
       => Points to location of override
       => Provides a directory name to search for::

           if os.curdir.split('/'+project_pat+'/')==project_name: 
              load project files

  See: 
     - tutorial_configuration.rst
     - developer_guide.rst
  Their use of PROJECT is problematic as they define it as a
  $SPACK_ROOT/etc/spack
  but SPACK_ROOT has to be the same as where spack is located under git.

New targets:
   o Package developers
   o Package users


Things that change:
   o fetch: Do not fetch -- expect package developer/users to manage git checkouts
   o stage: 
       + Make it easier to find the build directory
          - Get spack cd to work
       + Staging source code is not relevant.  
       + --keep-stage is always true.  

I want to put this into my ~/.spack/config::

  # These are repositories that developers manage rather than spack
  source_develop: 
    - /Users/kruger/dgFramework/apolloall

  # Where to place 
  build_stage_develop:
    - /scr_gabrielle/kruger/build-physics

But it doesn't even give me a parse error.


