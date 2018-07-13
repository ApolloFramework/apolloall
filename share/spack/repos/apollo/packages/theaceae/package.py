##############################################################################
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
#
# This is a template package file for Spack.  We've put "FIXME"
# next to all the things you'll want to change. Once you've handled
# them, you can save this file and test your package like this:
#
#     spack install theaceae
#
# You can edit this file again by typing:
#
#     spack edit theaceae
#
# See the Spack documentation for more information on packaging.
# If you submit this package back to Spack as a pull request,
# please first remove this boilerplate and all FIXME comments.
#
from spack import *


class Theaceae(CMakePackage):
    """Theaceae: A collection of benchmarks for testing 
       DPG and other hybrid methods.  Associated with Camellia.
    """

    homepage = "https://github.com/ApolloFramework/theaceae.git"
    url      = "https://github.com/ApolloFramework/theaceae.git"
    version('apollo', git='https://github.com/ApolloFramework/theaceae.git', branch='master')

    # FIXME: Add proper versions and checksums here.
    # version('1.2.3', '0123456789abcdef0123456789abcdef')

    # Need Camellia to build executables and sphinx to build docs
    # which we build all the time currently (could make variation)
    depends_on('camellia@apollo2')
    depends_on('py-sphinx')
    depends_on('py-sphinx-bootstrap-theme')

    def cmake_args(self):
        spec = self.spec
        options = [
            '-DCamellia_ROOT_DIR:PATH=%s' % spec['camella'].prefix,
            '-DENABLE_DOCS:BOOL=ON',
            '-DCMAKE_C_COMPILER:FILEPATH=%s' % spec['mpi'].mpicc,
            '-DCMAKE_CXX_COMPILER:FILEPATH=%s' % spec['mpi'].mpicxx,
            '-DCMAKE_Fortran_COMPILER:FILEPATH=%s' % spec['mpi'].mpifc
        ]
