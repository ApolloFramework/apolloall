##############################################################################
# This file is part of the Apolloall Framework.
# Created by Eric Howell, ehowell@txcorp.com, 
#
# This file is spack package file for camellia
#
# To install camellia type the command
#
# spack install camellia
#
# This will automatically identify, downloadm and configure all
# the external libraries needed for camellia. It will then 
# install camellia from soruce files in the $APOLLO_ROOT directory
#
# For details on space see https://github.com/spack/spack
#
# For details on camellia see 
##############################################################################
from spack import *

class Camellia(CMakePackage):
    """Camellia: user-friendly MPI-parallel adaptive finite element package,
       with support for DPG and other hybrid methods, built atop Trilinos.
    """

    homepage = "https://bitbucket.org/nateroberts/Camellia"
    url      = "https://bitbucket.org/nateroberts/camellia.git"

    maintainers = ['CamelliaDPG']
    version('master', git='https://bitbucket.org/nateroberts/camellia.git', branch='master')

    variant('moab', default=True, description='Compile with MOAB to include support for reading standard mesh formats')

    depends_on('trilinos+amesos+amesos2+belos+epetra+epetraext+exodus+ifpack+ifpack2+intrepid+intrepid2+kokkos+ml+muelu+sacado+shards+teuchos+tpetra+zoltan+mumps+superlu-dist+hdf5+zlib+pnetcdf@master,12.12.1:')
    depends_on('moab@:4', when='+moab')
    depends_on('hdf5@:1.10.2')
    depends_on('mpi')

    def cmake_args(self):
        spec = self.spec
        options = [
            '-DTrilinos_PATH:PATH=%s' % spec['trilinos'].prefix,
            '-DMPI_DIR:PATH=%s' % spec['mpi'].prefix,
            '-DBUILD_FOR_INSTALL:BOOL=ON'
        ]

        if '+moab' in spec:
            options.extend([
                '-DENABLE_MOAB:BOOL=ON',
                '-DMOAB_PATH:PATH=%s' % spec['moab'].prefix
            ])
        else:
            options.append('-DENABLE_MOAB:BOOL=OFF')

        return options
