#!/bin/bash

#set -e
#BUILD_TYPE=Release
BUILD_TYPE=RelWithDebInfo
export INSTALL_PREFIX=${SCRATCH}/internal/camellia2
script_name=config.sh



# A Camellia do-config script that uses Spack-built dependencies
# To find the dependencies, basic procedure is to 
#   1. Use spack to build camellia
#   2. Determine has of dependencies spack used in building camellia
#   3. Use hash to determine location


get_dep_loc () {

   local pkg=$1

   local hash=`spack find -dl camellia | grep $pkg | cut -f1 -d' '`
   location=`spack location -i \/${hash}`
}

get_dep_loc mpi
MPI_DIR=${location}

get_dep_loc hdf5
HDF5_DIR=${location}

get_dep_loc trilinos
TRILINOS_DIR=${location}

get_dep_loc moab
MOAB_DIR=${location}

cat << EOF > ${script_name} 
#!/bin/bash

# Clear cmake cache to ensure a clean configure.
rm -rf CMakeFiles CMakeCache.txt

cmake \\
  -D CMAKE_BUILD_TYPE="${BUILD_TYPE}" \\
  -D CMAKE_INSTALL_PREFIX:PATH=${INSTALL_PREFIX} \\
  -D BUILD_FOR_INSTALL:BOOL=ON \\
  -D CMAKE_INSTALL_RPATH_USE_LINK_PATH:BOOL=FALSE \
  -D CMAKE_COLOR_MAKEFILE:BOOL=ON \\
  -D CMAKE_VERBOSE_MAKEFILE:BOOL=ON \\
  -D ENABLE_PARALLEL:BOOL='TRUE' \\
  -D MPI_DIR:FILEPATH='${MPI_DIR}' \\
  -D CMAKE_C_COMPILER:FILEPATH='${MPI_DIR}/bin/mpicc' \\
  -D CMAKE_CXX_COMPILER:FILEPATH='${MPI_DIR}/bin/mpicxx' \\
  -D CMAKE_Fortran_COMPILER:FILEPATH='${MPI_DIR}/bin/mpif90' \\
  -D Trilinos_ROOT_DIR:PATH=${TRILINOS_DIR} \\
  -D Trilinos_PATH:PATH=${TRILINOS_DIR} \\
  -D ENABLE_MOAB:BOOL=ON \\
  -D Moab_ROOT_DIR:PATH=${MOAB_DIR} \\
  -D Moab_PATH:PATH=${MOAB_DIR} \\
  -D BUILD_DPGTESTS_DRIVER:BOOL=OFF \\
  -D BUILD_BRENDAN_DRIVERS:BOOL=ON \\
  -D BUILD_PRECONDITIONING_DRIVERS:BOOL=OFF \\
  -D BUILD_CONVECTION_DRIVERS:BOOL=ON \\
  ${APOLLO_ROOT}/camellia2

EOF
chmod ug+rx ${script_name}

