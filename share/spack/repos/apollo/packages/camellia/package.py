##############################################################################
# This file is part of the Apollo Framework.
# This file is an adaptation of the spack package file for Camellia
# that installs camellia from the apolloall repository instead of the
# standard camellia bitbucket repo.
#
# Modified by Eric Howell, ehowell@txcorp.com, 
#
# This file is a spack package file for camellia
#
# To install camellia type the command
#
# spack install camellia
#
# This will automatically identify, downloadm and configure all
# the external libraries needed for camellia. It will then 
# install camellia from soruce files in the $APOLLO_ROOT directory
#
# For details on spack see https://github.com/spack/spack
#
# For details on camellia see https://bitbucket.org/nateroberts/Camellia
#
# For details on the Apollo Framework see https://github.com/ApolloFramework/
##############################################################################

########################LLNL Copyright infor for SPACK#########################
# Copyright (c) 2013-2018, Lawrence Livermore National Security, LLC.
# Produced at the Lawrence Livermore National Laboratory.
#
# This file is part of Spack.
# Created by Todd Gamblin, tgamblin@llnl.gov, All rights reserved.
# LLNL-CODE-647188
#
# For details, see https://github.com/spack/spack
# Please also see the NOTICE and LICENSE files for our notice and the LGPL.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License (as
# published by the Free Software Foundation) version 2.1, February 1999.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the IMPLIED WARRANTY OF
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the terms and
# conditions of the GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
##############################################################################

from spack import *

class Camellia(CMakePackage):
    """Camellia: user-friendly MPI-parallel adaptive finite element package,
       with support for DPG and other hybrid methods, built atop Trilinos.
    """

    homepage = "https://bitbucket.org/nateroberts/Camellia"
    url      = "https://bitbucket.org/nateroberts/camellia.git"

    maintainers = ['CamelliaDPG']
    version('apollo', git='https://github.com/ApolloFramework/Camellia.git', branch='master')
    version('apollo2', git='https://github.com/ApolloFramework/Camellia2.git', branch='master-github')

    version('nates_master', git='https://bitbucket.org/nateroberts/camellia.git', branch='master')

    variant('moab', default=True, description='Compile with MOAB to include support for reading standard mesh formats')

    #depends_on('trilinos+amesos+amesos2+belos+epetra+epetraext+exodus+ifpack+ifpack2+intrepid+intrepid2+kokkos+ml+muelu+sacado+shards+teuchos+tpetra+zoltan+mumps+superlu-dist+hdf5+zlib+pnetcdf@master,12.12.1:')
    depends_on('trilinos+amesos2+belos+epetra+epetraext+exodus+ifpack+ifpack2+intrepid+intrepid2+kokkos+ml+muelu+sacado+shards+teuchos+tpetra+zoltan+mumps+superlu-dist+hdf5+zlib+pnetcdf@master,12.12.1:')
    #depends_on('moab@:4', when='+moab')
    depends_on('moab')
#later version of hdf5 compile but fail at run time
#bug related to H5Dcreate2():
#1.8.10 fails to compile
    depends_on('hdf5@:1.8.12')
    depends_on('mpi')

    def cmake_args(self):
        spec = self.spec
        options = [
            '-DTrilinos_PATH:PATH=%s' % spec['trilinos'].prefix,
            '-DTrilinos_ROOT_DIR:PATH=%s' % spec['trilinos'].prefix,
            '-DBUILD_FOR_INSTALL:BOOL=ON',
            '-DCMAKE_C_COMPILER:FILEPATH=%s' % spec['mpi'].mpicc,
            '-DCMAKE_CXX_COMPILER:FILEPATH=%s' % spec['mpi'].mpicxx,
            '-DCMAKE_Fortran_COMPILER:FILEPATH=%s' % spec['mpi'].mpifc
        ]

        if '@apollo' in spec:
           options.extend([
               '-DENABLE_PARALLEL:BOOL=ON',
           ])
        else:
           options.extend([
               '-DMPI_DIR:PATH=%s' % spec['mpi'].prefix,
           ])
        if '+moab' in spec:
            if '@apollo' in spec:
              options.extend([
                  '-DENABLE_MOAB:BOOL=ON',
                  '-DMoab_ROOT_DIR:PATH=%s' % spec['moab'].prefix,
                  '-DMOAB_PATH:PATH=%s' % spec['moab'].prefix
              ])
            else:
              options.extend([
                  '-DENABLE_MOAB:BOOL=ON',
                  '-DMOAB_PATH:PATH=%s' % spec['moab'].prefix
              ])
        else:
            options.append('-DENABLE_MOAB:BOOL=OFF')

        return options
