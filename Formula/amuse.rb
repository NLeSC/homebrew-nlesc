class Amuse < Formula
  include Language::Python::Virtualenv

  desc "Python virtualenv for AMUSE"
  homepage "http://www.amusecode.org/"
  url "https://github.com/amusecode/amuse.git", :tag => "v12.0.0"
  head  "https://github.com/amusecode/amuse.git"

  hdf5 = "nlesc/nlesc/hdf5"
  netcdf = "nlesc/nlesc/netcdf"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "gcc" # for gfortran
  depends_on "python3" => :optional
  depends_on "open-mpi"
  depends_on "fftw"
  depends_on "gsl"
  depends_on hdf5 => ["with-open-mpi"]
  depends_on netcdf

  # Python dependencies
  depends_on "numpy"

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/84/f4/5771e41fdf52aabebbadecc9381d11dea0fa34e4759b4071244fa094804c/docutils-0.14.tar.gz"
    sha256 "51e64ef2ebfb29cae1faa133b3710143496eca21c530f3f71424d77687764274"
  end

  resource "h5py" do
    url "https://files.pythonhosted.org/packages/43/27/a6e7dcb8ae20a4dbf3725321058923fec262b6f7835179d78ccc8d98deec/h5py-2.9.0.tar.gz"
    sha256 "9d41ca62daf36d6b6515ab8765e4c8c4388ee18e2a665701fef2b41563821002"
  end

  resource "mpi4py" do
    url "https://files.pythonhosted.org/packages/04/f5/a615603ce4ab7f40b65dba63759455e3da610d9a155d4d4cece1d8fd6706/mpi4py-3.0.2.tar.gz"
    sha256 "f8d629d1e3e3b7b89cb99d0e3bc5505e76cc42089829807950d5c56606ed48e0"
  end

  resource "nose" do
    url "https://files.pythonhosted.org/packages/58/a5/0dc93c3ec33f4e281849523a5a913fa1eea9a3068acfa754d44d88107a44/nose-1.3.7.tar.gz"
    sha256 "f1bffef9cbc82628f6e7d7b40d7e255aefaa1adb6a1b1d26c69a8b79e6208a98"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"
    sha256 "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"
  end

  resource "wheel" do
    url "https://files.pythonhosted.org/packages/1d/b0/f478e80aeace42fe251225a86752799174a94314c4a80ebfc5bf0ab1153a/wheel-0.33.4.tar.gz"
    sha256 "62fcfa03d45b5b722539ccbc07b190e4bfff4bb9e3a4d470dd9f6a0981002565"
  end

  patch <<-END_VIRTUALENV_PATCH
--- a/amuse-env   2019-03-12 13:49:49.000000000 +0100
+++ b/amuse-env   2019-03-12 13:49:37.000000000 +0100
@@ -0,0 +1,49 @@
+prepend_path () {
+    eval $1=\\"$2${!1:+":"}${!1}\\"
+}
+
+extend_path () {
+  if ! [ -z "${!1+_}" ]; then
+      eval _OLD_AMUSE_$1=\\"${!1}\\"
+  fi
+
+  prepend_path "$1" "$2"
+}
+
+extend_path PATH "#{Formula[netcdf].bin}:#{Formula[hdf5].bin}"
+
+. LIBEXEC_PREFIX/bin/activate
+
+extend_path PKG_CONFIG_PATH "#{Formula[netcdf].lib}/pkgconfig"
+extend_path C_INCLUDE_PATH "#{Formula[netcdf].include}:#{Formula[hdf5].include}"
+extend_path CPLUS_INCLUDE_PATH "#{Formula[netcdf].include}:#{Formula[hdf5].include}"
+extend_path LIBRARY_PATH "#{Formula[netcdf].lib}:#{Formula[hdf5].lib}"
+
+unset -f prepend_path extend_path
+
+eval 'deactivate () {
+    '"$(declare -f deactivate | tail -n+2)"'
+
+    reset_path () {
+        local OLDNAME="_OLD_AMUSE_$1"
+        if [ -z "${!OLDNAME+_}" ]; then
+            unset $1
+        else
+            eval $1=\\"${!OLDNAME}\\"
+            unset $OLDNAME
+        fi
+    }
+
+    reset_path PATH
+    reset_path PKG_CONFIG_PATH
+    reset_path C_INCLUDE_PATH
+    reset_path CPLUS_INCLUDE_PATH
+    reset_path LIBRARY_PATH
+
+    unset -f reset_path
+}'
+
+export PATH PKG_CONFIG_PATH C_INCLUDE_PATH CPLUS_INCLUDE_PATH LIBRARY_PATH
+if [ -n "${BASH-}" ] || [ -n "${ZSH_VERSION-}" ] ; then
+    hash -r 2>/dev/null
+fi
END_VIRTUALENV_PATCH

  patch <<-END_NF_CONFIG_PATCH
--- a/nf-config   2019-03-12 13:49:49.000000000 +0100
+++ b/nf-config   2019-03-12 13:49:37.000000000 +0100
@@ -0,0 +1,7 @@
+#!/usr/bin/env sh
+if [ "$#" -ne 1 ] || [ "$1" != "--prefix" ]; then
+  echo "nf-config not fully implemented"
+  exit 1
+fi
+
+printf "#{Formula[netcdf].opt_prefix}\\n"
END_NF_CONFIG_PATCH

  def install
    venv = virtualenv_create(libexec)

    py_deps = resources.map(&:name).to_set
    py_deps.each do |r|
      venv.pip_install resource(r)
    end

    system "#{libexec}/bin/python", "packages/amuse-framework/setup.py", "sdist"
    version = `#{libexec}/bin/python packages/amuse-framework/setup.py --version`
    sdist_file = "dist/amuse-framework-" + version.strip + ".tar.gz"
    system "#{libexec}/bin/pip", "install", "-v", "--no-deps", "--ignore-installed", sdist_file

    inreplace "#{libexec}/bin/activate", "`basename \\\"$VIRTUAL_ENV\\\"`",
      "AMUSE"

    inreplace "amuse-env", "LIBEXEC_PREFIX", libexec
    libexec.install "amuse-env"

    chmod 0755, "nf-config"
    (libexec/"bin").install "nf-config"
  end

  def caveats
    s = <<EOS
Dependencies were installed in a virtualenv.
To activate it and be able to build AMUSE from source, run:

    . #{prefix}/libexec/amuse-env

Or add an alias to do so to your ~/.bashrc:

    alias amuse-env='. #{prefix}/libexec/amuse-env'

To deactivate, run:

    deactivate

EOS
    s
  end

  test do
    system "false"
  end
end
