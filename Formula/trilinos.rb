class Trilinos < Formula
  desc "Solution of large-scale, multi-physics problems"
  homepage "https://trilinos.github.io/"
  url "http://trilinos.csbsju.edu/download/files/trilinos-12.12.1-Source.tar.gz"
  sha256 "7c67d83befbeabc773661bcdfee2850c404d249160b755d3f1be2e96f564f9fd"
  head "https://github.com/trilinos/Trilinos.git"

  hdf5 = "nlesc/nlesc/hdf5"
  parmetis = "nlesc/nlesc/parmetis"

  keg_only "only configured to work for nlesc/nlesc/i-emic"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "gcc" # for gfortran
  depends_on "python3" => :optional
  depends_on "open-mpi"
  depends_on "openblas"
  depends_on "lapack"
  depends_on "metis"
  depends_on parmetis
  depends_on hdf5 => ["with-open-mpi"]

  def install
    ENV.cxx11

    args  = %W[
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DCMAKE_BUILD_TYPE:STRING=Release
      -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON

      -DBUILD_SHARED_LIBS=ON

      -DTPL_ENABLE_MPI:BOOL=ON
      -DTPL_ENABLE_HDF5:BOOL=ON

      -DTPL_ENABLE_METIS:BOOL=ON
      -DTPL_METIS_INCLUDE_DIRS:PATH=#{Formula["metis"].include}
      -DMETIS_LIBRARY_DIRS:PATH=#{Formula["metis"].lib}

      -DTPL_ENABLE_ParMETIS:BOOL=ON
      -DTPL_ParMETIS_INCLUDE_DIRS:PATH=#{Formula["nlesc/nlesc/parmetis"].include}
      -DParMETIS_LIBRARY_DIRS:PATH=#{Formula["nlesc/nlesc/parmetis"].lib}

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
    ]

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "VERBOSE=1"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
