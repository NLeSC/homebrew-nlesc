class Amuse < Formula
  include Language::Python::Virtualenv

  desc "Python virtualenv for AMUSE"
  homepage "http://www.amusecode.org/"
  url "https://github.com/amusecode/amuse.git", :tag => "v11.3.5"
  head  "https://github.com/amusecode/amuse.git"

  depends_on "cmake" => :build
  depends_on "gcc" # for gfortran
  depends_on "python3" => :optional
  depends_on "open-mpi"
  depends_on "fftw"
  depends_on "gsl"
  depends_on "jupyter"
  depends_on "nlesc/nlesc/hdf5" => ["with-open-mpi"]
  depends_on "nlesc/nlesc/netcdf"

  patch :DATA

  def install
    venv = virtualenv_create(libexec)
    %w[numpy nose docutils mpi4py h5py scipy pandas seaborn].each do |r|
      venv.pip_install r
    end

    inreplace "#{libexec}/bin/activate", "`basename \\\"$VIRTUAL_ENV\\\"`",
      "AMUSE"

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

__END__
--- a/amuse-env   2019-03-12 13:49:49.000000000 +0100
+++ b/amuse-env   2019-03-12 13:49:37.000000000 +0100
@@ -0,0 +1,57 @@
+. LIBEXEC_PREFIX/bin/activate
+
+prepend_path () {
+    eval $1=\"$2${!1:+":"}${!1}\"
+}
+
+extend_path () {
+  if [ -z "${!1+_}" ]; then
+      eval _OLD_VIRTUAL_$1="${!1}"
+  fi
+
+  prepend_path "$1" "$2"
+}
+
+reset_path () {
+    local OLDNAME="_OLD_VIRTUAL_$1"
+    if [ -z "${!OLDNAME+_}" ]; then
+        eval $1="${!OLDNAME}"
+        unset $OLDNAME
+    else
+        unset $1
+    fi
+}
+
+rename_function () {
+    local ORIGINAL=$(declare -f $1)
+    local NEW_FUNC="$2${ORIGINAL#$1}"
+    eval "$NEW_FUNC"
+}
+
+rename_function deactivate _old_virtual_
+
+deactivate () {
+    _old_virtual_deactivate
+
+    reset_path PKG_CONFIG_PATH
+    reset_path C_INCLUDE_PATH
+    reset_path CPLUS_INCLUDE_PATH
+
+    unset -f _old_virtual_deactivate reset_path
+}
+
+prepend_path PATH "/usr/local/opt/netcdf/bin"
+prepend_path PATH "/usr/local/opt/hdf5/bin"
+
+extend_path PKG_CONFIG_PATH "/usr/local/opt/netcdf/lib/pkgconfig"
+extend_path C_INCLUDE_PATH "/usr/local/opt/netcdf/include"
+extend_path C_INCLUDE_PATH "/usr/local/opt/hdf5/include"
+extend_path CPLUS_INCLUDE_PATH "/usr/local/opt/netcdf/include"
+extend_path CPLUS_INCLUDE_PATH "/usr/local/opt/hdf5/include"
+
+unset -f prepend_path extend_path rename_function
+
+export PATH PKG_CONFIG_PATH C_INCLUDE_PATH CPLUS_INCLUDE_PATH
+if [ -n "${BASH-}" ] || [ -n "${ZSH_VERSION-}" ] ; then
+    hash -r 2>/dev/null
+fi
