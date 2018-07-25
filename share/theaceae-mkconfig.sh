#!/bin/bash

#set -e
#BUILD_TYPE=Release
BUILD_TYPE=RelWithDebInfo
export INSTALL_PREFIX=${SCRATCH}/internal/theaceae
script_name=config.sh



# Generate a theaceae script for running cmake that uses Spack-built dependencies
# We only need Camellia and the rest of the dependencies go from there.


get_camellia_spack () {

   local camellia_str=$1

   if test ${camellia_str:0:3} == 'cam'; then
     # Assume hash does not start with 
     CAMELLIA_DIR=`spack location -i ${camellia_str}`
     local hash=`spack find -dl $camellia_str | grep mpi | cut -f1 -d' '`
   else
     # This is for the hash
     CAMELLIA_DIR=`spack location -i \/${camellia_str}`
     local hash=`spack find -dl \/${camellia_str} | grep mpi | cut -f1 -d' '`
   fi
   MPI_DIR=`spack location -i \/${hash}`
}

# Normal method
#get_camellia_spack camellia@apollo2

# Do a specific hash
get_camellia_spack 'qominb5'

# Manually specify location instead
#CAMELLIA_DIR="${SCRATCH}/internal/camellia2"

cat << EOF > ${script_name} 
#!/bin/bash

# Clear cmake cache to ensure a clean configure.
rm -rf CMakeFiles CMakeCache.txt

cmake \\
  -D CMAKE_BUILD_TYPE="${BUILD_TYPE}" \\
  -D CMAKE_INSTALL_PREFIX:PATH=${INSTALL_PREFIX} \\
  -D CMAKE_INSTALL_RPATH_USE_LINK_PATH:BOOL=FALSE \\
  -D CMAKE_COLOR_MAKEFILE:BOOL=ON \\
  -D CMAKE_VERBOSE_MAKEFILE:BOOL=ON \\
  -D ENABLE_DOCS:BOOL=TRUE \\
  -D ENABLE_PARALLEL:BOOL=TRUE \\
  -D MPI_ROOT_DIR:PATH='${MPI_DIR}' \\
  -D CMAKE_C_COMPILER:FILEPATH='${MPI_DIR}/bin/mpicc' \\
  -D CMAKE_CXX_COMPILER:FILEPATH='${MPI_DIR}/bin/mpicxx' \\
  -D CMAKE_Fortran_COMPILER:FILEPATH='${MPI_DIR}/bin/mpif90' \\
  -D Camellia_ROOT_DIR:PATH=${CAMELLIA_DIR} \\
  ${APOLLO_ROOT}/theaceae

EOF
chmod ug+rx ${script_name}

