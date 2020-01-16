class Slicot < Formula
  desc "Fortran 77 algorithms for computations in systems and control theory"
  homepage "http://www.slicot.org/"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/s/slicot/slicot_5.0+20101122.orig.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/s/slicot/slicot_5.0+20101122.orig.tar.gz"
  version "5.0+20101122"
  sha256 "fa80f7c75dab6bfaca93c3b374c774fd87876f34fba969af9133eeaea5f39a3d"

  bottle do
    root_url "http://gitlabci.ci-nlesc.surf-hosted.nl"
    sha256 "9ba93b26a6d66923223b6f1c1509515ab59480a8f429564c7813e4ae619f3534" => :mojave
  end

  depends_on "gcc" # for gfortran

  def install
    system "make", "lib", "OPTS=-fPIC", "SLICOTLIB=../libslicot.a", "FORTRAN=gfortran",
           "LOADER=gfortran"
    system "make", "clean"
    system "make", "lib", "OPTS=-fPIC -fdefault-integer-8", "SLICOTLIB=../libslicot64.a",
           "FORTRAN=gfortran", "LOADER=gfortran"
    lib.install "libslicot.a", "libslicot64.a"
  end
end
