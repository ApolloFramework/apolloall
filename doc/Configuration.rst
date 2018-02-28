
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



