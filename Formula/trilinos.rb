class Trilinos < Formula
  desc "Solution of large-scale, multi-physics problems"
  homepage "https://trilinos.github.io/"
  url "https://github.com/trilinos/Trilinos.git", :tag => "trilinos-release-13-0-1"
  version "13.0.1"

  bottle do
    root_url "https://github.com/nlesc/homebrew-nlesc/releases/download/bottles/"
    sha256 catalina: "758dd840a885bea5354165a1d39eb2e04ed26340f28cd47a9913ddeb1f46af4f"
  end

  netcdf = "nlesc/nlesc/netcdf-mpi"
  parmetis = "nlesc/nlesc/parmetis"

  keg_only "it is only configured to work for OMUSE"

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "open-mpi"
  depends_on "metis"
  depends_on "python@3.9"
  depends_on "numpy"
  depends_on "hdf5-mpi"
  depends_on "swig@4"
  depends_on parmetis
  depends_on netcdf

  patch <<-END_TEUCHOS_PATCH
--- a/packages/teuchos/numerics/src/Teuchos_LAPACK_wrappers.hpp        2021-03-19 16:14:52.000000000 +0100
+++ b/packages/teuchos/numerics/src/Teuchos_LAPACK_wrappers.hpp        2021-03-19 16:15:02.000000000 +0100
@@ -669,24 +669,8 @@
 void PREFIX ZGEBAL_F77(Teuchos_fcd, const int* n, std::complex<double>* a, const int* lda, int* ilo, int* ihi, double* scale, int* info);
 void PREFIX ZGEBAK_F77(Teuchos_fcd, Teuchos_fcd, const int* n, const int* ilo, const int* ihi, const double* scale, const int* m, std::complex<double>* V, const int* ldv, int* info);

-// Returning the C99 complex type instead of the C++ complex type
-// avoids build warnings of the following form:
-//
-// warning: $FUNCTION_NAME has C-linkage specified, but returns
-// user-defined type 'std::complex<double>' which is incompatible with
-// C [-Wreturn-type-c-linkage]
-//
-// However, we may only use those types if the C++ compiler supports
-// them.  C++11 implies C99 support generally, so asking whether the
-// compiler supports C++11 is a reasonable test.  Unless you're using
-// Visual Studio, which supports subsets of C++11, but not this.
-#if (defined(HAVE_TEUCHOSCORE_CXX11) && !defined(_MSC_VER))
-float _Complex PREFIX CLARND_F77(const int* idist, int* seed);
-double _Complex PREFIX ZLARND_F77(const int* idist, int* seed);
-#else // NOT HAVE_TEUCHOSCORE_CXX11 || _MSC_VER
 std::complex<float> PREFIX CLARND_F77(const int* idist, int* seed);
 std::complex<double> PREFIX ZLARND_F77(const int* idist, int* seed);
-#endif
END_TEUCHOS_PATCH

  patch <<-END_PYTRILINOS_PATCH
--- a/packages/PyTrilinos/src/gen_teuchos_rcp.py.in       2021-03-19 17:24:05.000000000 +0100
+++ b/packages/PyTrilinos/src/gen_teuchos_rcp.py.in       2021-03-19 17:24:22.000000000 +0100
@@ -53,7 +53,7 @@
 ################################################################################

 def get_mpi_version():
-    header = "${MPI_BASE_DIR}/include/mpi.h"
+    header = MPI_BASE_DIR + "/include/mpi.h"
     version = ""
     for line in open(header, 'r').readlines():
         if "MPI_VERSION" in line:
END_PYTRILINOS_PATCH

  def install
    ENV.cxx11

    args  = %W[
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DCMAKE_BUILD_TYPE:STRING=Release
      -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
      -DCMAKE_CXX_EXTENSIONS=ON

      -DBUILD_SHARED_LIBS=ON

      -DTPL_ENABLE_MPI:BOOL=ON
      -DTPL_ENABLE_HDF5:BOOL=ON
      -DTPL_HDF5_INCLUDE_DIRS:PATH=#{Formula["hdf5-mpi"].include}

      -DTPL_ENABLE_METIS:BOOL=ON
      -DTPL_METIS_INCLUDE_DIRS:PATH=#{Formula["metis"].include}
      -DMETIS_LIBRARY_DIRS:PATH=#{Formula["metis"].lib}

      -DTPL_ENABLE_ParMETIS:BOOL=ON
      -DTPL_ParMETIS_INCLUDE_DIRS:PATH=#{Formula["nlesc/nlesc/parmetis"].include}
      -DParMETIS_LIBRARY_DIRS:PATH=#{Formula["nlesc/nlesc/parmetis"].lib}

      -DTrilinos_ENABLE_PyTrilinos=ON
      -DPYTHON_EXECUTABLE=#{Formula["python@3.9"].bin}/python3
      -DTrilinos_ENABLE_STK:BOOL=NO

      -DBelos_ENABLE_Experimental:BOOL=OFF

      -DTrilinos_VERBOSE_CONFIGURE:BOOL=OFF
      -DTrilinos_ENABLE_DEBUG=OFF
      -DTrilinos_ENABLE_Export_Makefiles:BOOL=ON
      -DTrilinos_ENABLE_EXAMPLES:BOOL=OFF
      -DTrilinos_ENABLE_TESTS:BOOL=OFF
      -DTrilinos_ENABLE_Teuchos:BOOL=ON
      -DTrilinos_ENABLE_Epetra:BOOL=ON
      -DTrilinos_ENABLE_EpetraExt:BOOL=ON
      -DTrilinos_ENABLE_Ifpack:BOOL=ON
      -DTrilinos_ENABLE_Amesos:BOOL=ON
      -DTrilinos_ENABLE_Anasazi:BOOL=ON
      -DTrilinos_ENABLE_Belos:BOOL=ON
      -DTrilinos_ENABLE_ML:BOOL=ON
      -DTrilinos_ENABLE_OpenMP:BOOL=OFF

      -DTeuchos_ENABLE_COMPLEX=ON
    ]

    mkdir "build" do
      system "cmake", "..", *args
      inreplace "Makefile.export.Trilinos", "-lpytrilinos ", ""
      inreplace "Makefile.export.Trilinos_install", "-lpytrilinos ", ""
      system "make", "VERBOSE=1"
      system "make", "install"
    end

    inreplace "#{prefix}/lib/cmake/Trilinos/TrilinosConfig.cmake", "PyTrilinos;",""
  end

  test do
    system "false"
  end
end
