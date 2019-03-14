class Amuse < Formula
  include Language::Python::Virtualenv

  desc "Python virtualenv for AMUSE"
  homepage "http://www.amusecode.org/"
  url "https://github.com/amusecode/amuse.git", :tag => "v11.3.5"
  head  "https://github.com/amusecode/amuse.git"

  hdf5 = "nlesc/nlesc/hdf5"
  netcdf = "nlesc/nlesc/netcdf"

  depends_on "cmake" => :build
  depends_on "gcc" # for gfortran
  depends_on "python3" => :optional
  depends_on "open-mpi"
  depends_on "fftw"
  depends_on "gsl"
  depends_on "jupyter"
  depends_on hdf5 => ["with-open-mpi"]
  depends_on netcdf

  patch <<-END_PATCH
--- a/amuse-env   2019-03-12 13:49:49.000000000 +0100
+++ b/amuse-env   2019-03-12 13:49:37.000000000 +0100
@@ -0,0 +1,48 @@
+. LIBEXEC_PREFIX/bin/activate
+
+prepend_path () {
+    eval $1=\\"$2${!1:+":"}${!1}\\"
+}
+
+extend_path () {
+  if ! [ -z "${!1+_}" ]; then
+      eval _OLD_VIRTUAL_$1="${!1}"
+  fi
+
+  prepend_path "$1" "$2"
+}
+
+eval 'deactivate () {
+    '"$(declare -f deactivate | tail -n+2)"'
+
+    reset_path () {
+        local OLDNAME="_OLD_VIRTUAL_$1"
+        if [ -z "${!OLDNAME+_}" ]; then
+            unset $1
+        else
+            eval $1="${!OLDNAME}"
+            unset $OLDNAME
+        fi
+    }
+
+    reset_path PKG_CONFIG_PATH
+    reset_path C_INCLUDE_PATH
+    reset_path CPLUS_INCLUDE_PATH
+    reset_path LIBRARY_PATH
+
+    unset -f reset_path
+}'
+
+prepend_path PATH "#{Formula[netcdf].bin}:#{Formula[hdf5].bin}"
+
+extend_path PKG_CONFIG_PATH "#{Formula[netcdf].lib}/pkgconfig"
+extend_path C_INCLUDE_PATH "#{Formula[netcdf].include}:#{Formula[hdf5].include}"
+extend_path CPLUS_INCLUDE_PATH "#{Formula[netcdf].include}:#{Formula[hdf5].include}"
+extend_path LIBRARY_PATH "#{Formula[netcdf].lib}:#{Formula[hdf5].lib}"
+
+unset -f prepend_path extend_path
+
+export PATH PKG_CONFIG_PATH C_INCLUDE_PATH CPLUS_INCLUDE_PATH LIBRARY_PATH
+if [ -n "${BASH-}" ] || [ -n "${ZSH_VERSION-}" ] ; then
+    hash -r 2>/dev/null
+fi
END_PATCH

  def install
    venv = virtualenv_create(libexec)
    %w[numpy nose docutils mpi4py h5py scipy pandas seaborn].each do |r|
      venv.pip_install r
    end

    inreplace "#{libexec}/bin/activate", "`basename \\\"$VIRTUAL_ENV\\\"`",
      "AMUSE"

    ohai "#{Formula["nlesc/nlesc/netcdf"].lib}"

    inreplace "amuse-env", "LIBEXEC_PREFIX", libexec
    bin.mkpath
    bin.install "amuse-env"
  end

  def caveats
    s = <<EOS
Dependencies were installed in a virtualenv.
To activate it and be able to build AMUSE from source, run:

    . #{prefix}/bin/amuse-env

Or add an alias to do so to your ~/.bashrc:

    alias amuse-env='. #{prefix}/bin/amuse-env'

To deactivate, run:

    deactivate

EOS
    s
  end

  test do
    system "false"
  end
end
