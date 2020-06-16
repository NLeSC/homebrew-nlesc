class Slicot < Formula
  desc "Fortran 77 algorithms for computations in systems and control theory"
  homepage "http://www.slicot.org/"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/s/slicot/slicot_5.0+20101122.orig.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/s/slicot/slicot_5.0+20101122.orig.tar.gz"
  version "5.0+20101122"
  sha256 "fa80f7c75dab6bfaca93c3b374c774fd87876f34fba969af9133eeaea5f39a3d"

  bottle do
    root_url "https://github.com/nlesc-smcm/i-emic/releases/download/depends/"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "1b8139ac2fb137ada8f1b0b8a2536f7ceaae58633d79fe8923cc440462872a1e" => :mojave
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
