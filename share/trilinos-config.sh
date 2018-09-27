#!/bin/sh

#  I haven't made this into a generation script, but basically this is what I use
#  to compile a version of trilinos that works for camellia.  
#  It was created by looking at what works for spack and kudos to Rood for figuring
#  out a lot of the dependency issues.

# Things that didn't work that I should report:
#   TPL_ENABLE_MPI and make test
#   USE_XSDK_DEFAULTS=YES and test

cmake \
      -D CMAKE_INSTALL_PREFIX=$SCRATCH/contrib-clangcxx11/trilinos-parcamellia \
      -D CMAKE_VERBOSE_MAKEFILE=1 \
      -D CMAKE_C_COMPILER:FILEPATH='mpicc' \
      -D CMAKE_CXX_COMPILER:FILEPATH='mpicxx' \
      -D CMAKE_Fortran_COMPILER:FILEPATH='mpif90' \
      -D CMAKE_AR=/usr/bin/ar \
      -D CMAKE_RANLIB=/usr/bin/ranlib \
      -D CMAKE_C_FLAGS:STRING="-fstack-protector -Qunused-arguments -g -O3" \
      -D CMAKE_CXX_FLAGS:STRING="-fstack-protector -g -O3" \
      -D CMAKE_Fortran_FLAGS:STRING="-ffree-line-length-0 -g -O" \
      -D BUILD_SHARED_LIBS=off \
      -D USE_XSDK_DEFAULTS=NO \
      -D CMAKE_BUILD_TYPE=RELEASE \
      -D XSDK_ENABLE_DEBUG=NO \
      -D Trilinos_ENABLE_OpenMP=NO \
      -D Trilinos_ENABLE_EXPLICIT_INSTANTIATION=ON \
      -D Trilinos_DISABLE_ENABLED_FORWARD_DEP_PACKAGES=ON \
      -D Trilinos_EXTRA_LINK_FLAGS="-L/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/9.0.0/lib/darwin -L/opt/homebrew/Cellar/gcc/8.1.0/lib/gcc/8  -Wl,-rpath,/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/9.0.0/lib/darwin -lmpifort -lgfortran -lgcc_ext.10.5 -lquadmath -lm -lmpicxx -lc++ -Wl,-rpath,/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/9.0.0/lib/darwin -L/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/9.0.0/lib/darwin -ldl -lmpi -lpmpi -lpthread -lSystem -Wl,-rpath,/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/9.0.0/lib/darwin -L/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/9.0.0/lib/darwin -ldl" \
      -D Teuchos_ENABLE_FLOAT=OFF \
      -D Teuchos_ENABLE_COMPLEX=OFF \
      -D Tpetra_INST_FLOAT=OFF \
      -D Tpetra_INST_COMPLEX_FLOAT=OFF \
      -D Tpetra_INST_COMPLEX_DOUBLE=OFF \
      -D Trilinos_ENABLE_Teuchos=ON \
      -D Trilinos_ENABLE_Kokkos=ON \
      -D Trilinos_ENABLE_KokkosExample=ON \
      -D Trilinos_ENABLE_TESTS=ON \
      -D Teuchos_ENABLE_TESTS=ON \
      -D Trilinos_ENABLE_Epetra=ON \
      -D Trilinos_ENABLE_EpetraExt=ON \
      -D Trilinos_ENABLE_AztecOO=ON \
      -D Trilinos_ENABLE_Ifpack=ON \
      -D Trilinos_ENABLE_Amesos2=ON \
      -D Trilinos_ENABLE_Tpetra=ON \
      -D Trilinos_ENABLE_Sacado=ON \
      -D Trilinos_ENABLE_Zoltan=ON \
      -D Trilinos_ENABLE_Stratimikos=OFF \
      -D Trilinos_ENABLE_Thyra=OFF \
      -D Trilinos_ENABLE_Isorropia=OFF \
      -D Trilinos_ENABLE_ML=OFF \
      -D Trilinos_ENABLE_Belos=ON \
      -D Trilinos_ENABLE_Anasazi=ON \
      -D Trilinos_ENABLE_Zoltan2=ON \
      -D Trilinos_ENABLE_Ifpack2=ON \
      -D Trilinos_ENABLE_Intrepid=ON \
      -D Trilinos_ENABLE_Intrepid2=ON \
      -D Trilinos_ENABLE_ShyLU=OFF \
      -D Trilinos_ENABLE_NOX=ON \
      -D Trilinos_ENABLE_MueLu=OFF \
      -D Trilinos_ENABLE_Stokhos=OFF \
      -D Trilinos_ENABLE_ROL=OFF \
      -D Trilinos_ENABLE_Piro=OFF \
      -D Trilinos_ENABLE_Pike=OFF \
      -D Trilinos_ENABLE_TrilinosCouplings=OFF \
      -D Trilinos_ENABLE_Panzer=OFF \
      -D Trilinos_ENABLE_ForTrilinos=OFF \
      -D Trilinos_ENABLE_SEACAS:BOOL=ON \
      -D Trilinos_ENABLE_SEACASExodus:BOOL=ON \
      -D Trilinos_ENABLE_SEACASEpu:BOOL=ON \
      -D Trilinos_ENABLE_SEACASExodiff:BOOL=ON \
      -D Trilinos_ENABLE_SEACASNemspread:BOOL=ON \
      -D Trilinos_ENABLE_SEACASNemslice:BOOL=ON \
      -D Trilinos_ENABLE_SEACASIoss:BOOL=OFF \
      -D Trilinos_ENABLE_STK=OFF \
      -D Trilinos_ENABLE_FEI=OFF \
      -D TPL_ENABLE_Boost=ON \
      -D TPL_Boost_DIR="/scr_gabrielle/kruger/PTSOLVE/boost" \
      -D TPL_ENABLE_Matio=OFF \
      -D TPL_ENABLE_GLM=OFF \
      -D TPL_ENABLE_X11=OFF \
      -D TPL_BLAS_LIBRARIES="-llapack -lblas" \
      -D TPL_LAPACK_LIBRARIES="-llapack -lblas" \
      -D Trilinos_ASSERT_MISSING_PACKAGES=OFF \
      -D TPL_ENABLE_TPL_SuperLU=OFF \
      -D TPL_ENABLE_SuperLUDist=OFF \
      -D TPL_SuperLUDist_INCLUDE_DIRS="$SCRATCH/PTSOLVE/ossolvers-par/include" \
      -D TPL_SuperLUDist_LIBRARIES="-Wl,-rpath,$SCRATCH/PTSOLVE/ossolvers-par/lib -L$SCRATCH/PTSOLVE/ossolvers-par/lib -lsuperlu_dist"  \
      -D TPL_ENABLE_HYPRE=OFF \
      -D TPL_HYPRE_INCLUDE_DIRS="$SCRATCH/PTSOLVE/ossolvers-par/include" \
      -D TPL_HYPRE_LIBRARIES="-Wl,-rpath,$SCRATCH/PTSOLVE/ossolvers-par/lib -L$SCRATCH/PTSOLVE/ossolvers-par/lib -lHYPRE " \
      -D TPL_ENABLE_TPL_PARDISO_MKL=OFF \
      -D TPL_ENABLE_METIS=OFF \
      -D TPL_METIS_INCLUDE_DIRS="$SCRATCH/PTSOLVE/ossolvers-par/include" \
      -D TPL_METIS_LIBRARIES="-Wl,-rpath,$SCRATCH/PTSOLVE/ossolvers-par/lib -L$SCRATCH/PTSOLVE/ossolvers-par/lib -lmetis" \
      -D TPL_ENABLE_ParMETIS=OFF \
      -D TPL_ParMETIS_INCLUDE_DIRS="$SCRATCH/PTSOLVE/ossolvers-par/include" \
      -D TPL_ParMETIS_LIBRARIES="-Wl,-rpath,$SCRATCH/PTSOLVE/ossolvers-par/lib -L$SCRATCH/PTSOLVE/ossolvers-par/lib -lparmetis" \
      -D TPL_ENABLE_Scotch=OFF \
      -D TPL_ENABLE_HDF5=ON \
      -D TPL_HDF5_INCLUDE_DIRS="/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/hdf5-1.8.12-uhtnaulbs25sdawz7cckhtftnjcv7r5q" \
      -D TPL_HDF5_LIBRARIES="-Wl,-rpath,/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/hdf5-1.8.12-uhtnaulbs25sdawz7cckhtftnjcv7r5q/lib -L/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/hdf5-1.8.12-uhtnaulbs25sdawz7cckhtftnjcv7r5q/lib -lhdf5_hl -lhdf5 -lz" \
      -D TPL_ENABLE_ExodusII=OFF \
      -D TPL_ENABLE_Pnetcdf:BOOL=ON \
      -D TPL_Netcdf_Enables_Netcdf4:BOOL=ON \
      -D TPL_Netcdf_PARALLEL:BOOL=ON \
      -D Pnetcdf_ROOT:PATH=/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/parallel-netcdf-1.8.0-zs466cneor5fupnjgk5mvy7i3bamrgav \
      -D TPL_Pnetcdf_LIBRARIES="/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/parallel-netcdf-1.8.0-zs466cneor5fupnjgk5mvy7i3bamrgav/lib/libpnetcdf.a" \
      -D TPL_Pnetcdf_INCLUDE_DIRS="/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/parallel-netcdf-1.8.0-zs466cneor5fupnjgk5mvy7i3bamrgav/include" \
      -D Pnetcdf_INCLUDE_DIRS="/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/parallel-netcdf-1.8.0-zs466cneor5fupnjgk5mvy7i3bamrgav/include" \
      -D TPL_ENABLE_Netcdf:BOOL=ON \
      -D TPL_Netcdf_LIBRARIES="-L/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/netcdf-4.6.1-ggvlg7kvy6pk4dh2jjqnhp76tgvvmigu/lib -lnetcdf" \
      -D TPL_Netcdf_INCLUDE_DIRS="/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/netcdf-4.6.1-ggvlg7kvy6pk4dh2jjqnhp76tgvvmigu/include" \
      -D Netcdf_INCLUDE_DIRS="/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/netcdf-4.6.1-ggvlg7kvy6pk4dh2jjqnhp76tgvvmigu/include" \
      -D TPL_ENABLE_Zlib:BOOL=ON \
      -D TPL_Zlib_LIBRARIES:PATH=/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/zlib-1.2.11-cpdvq4e7otjepbwdtxmgk5bzszze27fj/lib/libz.a \
      -D TPL_ENABLE_yaml-cpp:BOOL=ON \
      -D yaml-cpp_ROOT:PATH="$SCRATCH/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/yaml-cpp-0.6.2-z3wtdjdjhuqxc53awxyxry47di4itviw" \
      -D TPL_yaml-cpp_ROOT:PATH="$SCRATCH/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/yaml-cpp-0.6.2-z3wtdjdjhuqxc53awxyxry47di4itviw" \
      -D TPL_yaml-cpp_LIBRARIES:PATH="$SCRATCH/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/yaml-cpp-0.6.2-z3wtdjdjhuqxc53awxyxry47di4itviw/lib/libyaml-cpp.dylib" \
      -D TPL_yaml-cpp_INCLUDE_DIRS:PATH="$SCRATCH/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/yaml-cpp-0.6.2-z3wtdjdjhuqxc53awxyxry47di4itviw/include" \
       $HOME/triroot/trilinos
#      /scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/yaml-cpp-0.6.2-z3wtdjdjhuqxc53awxyxry47di4itviw/lib/libyaml-cpp.dylib
#      -D TPL_ENABLE_Netcdf=OFF \
#      -D TPL_Netcdf_INCLUDE_DIRS="$SCRATCH/PTSOLVE/ossolvers-par/include" \
#      -D TPL_Netcdf_LIBRARIES="-Wl,-rpath,$SCRATCH/PTSOLVE/ossolvers-par/lib -L$SCRATCH/PTSOLVE/ossolvers-par/lib -lnetcdf -lhdf5hl_fortran -lhdf5_fortran -lhdf5_hl -lhdf5 -lz" \
#      -D CMAKE_C_COMPILER:FILEPATH='/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/mpich-3.2.1-446wdumh4tdhpfumugjzidw67ovb7m6n/bin/mpicc' \
#      -D CMAKE_CXX_COMPILER:FILEPATH='/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/mpich-3.2.1-446wdumh4tdhpfumugjzidw67ovb7m6n/bin/mpicxx' \
#      -D CMAKE_Fortran_COMPILER:FILEPATH='/scr_gabrielle/kruger/spacksoftware/darwin-sierra-x86_64/clang-9.0.0-apple/mpich-3.2.1-446wdumh4tdhpfumugjzidw67ovb7m6n/bin/mpif90' \
