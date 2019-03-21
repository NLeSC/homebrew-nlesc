class Amuse < Formula
  include Language::Python::Virtualenv

  desc "Python virtualenv for AMUSE"
  homepage "http://www.amusecode.org/"
  url "https://github.com/amusecode/amuse.git", :tag => "v11.3.5"
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
  depends_on "jupyter"
  depends_on "numpy"
  depends_on "scipy"

  resource "backports.functools-lru-cache" do
    url "https://files.pythonhosted.org/packages/57/d4/156eb5fbb08d2e85ab0a632e2bebdad355798dece07d4752f66a8d02d1ea/backports.functools_lru_cache-1.5.tar.gz"
    sha256 "9d98697f088eb1b0fa451391f91afb5e3ebde16bbdb272819fd091151fda4f1a"
  end

  resource "Cycler" do
    url "https://files.pythonhosted.org/packages/c2/4b/137dea450d6e1e3d474e1d873cd1d4f7d3beed7e0dc973b06e8e10d32488/cycler-0.10.0.tar.gz"
    sha256 "cd7b2d1018258d7247a71425e9f26463dfb444d411c39569972f4ce586b0c9d8"
  end

  resource "kiwisolver" do
    url "https://files.pythonhosted.org/packages/31/60/494fcce70d60a598c32ee00e71542e52e27c978e5f8219fae0d4ac6e2864/kiwisolver-1.0.1.tar.gz"
    sha256 "ce3be5d520b4d2c3e5eeb4cd2ef62b9b9ab8ac6b6fedbaa0e39cdb6f50644278"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/b9/b8/6b32b3e84014148dcd60dd05795e35c2e7f4b72f918616c61fdce83d27fc/pyparsing-2.3.1.tar.gz"
    sha256 "66c9268862641abcac4a96ba74506e594c884e3f57690a696d21ad8210ed667a"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/ad/99/5b2e99737edeb28c71bcbec5b5dda19d0d9ef3ca3e92e3e925e7c0bb364c/python-dateutil-2.8.0.tar.gz"
    sha256 "c89805f6f4d64db21ed966fda138f8a5ed7a4fdbc1a8ee329ce1b74e3c74da9e"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/af/be/6c59e30e208a5f28da85751b93ec7b97e4612268bb054d0dff396e758a90/pytz-2018.9.tar.gz"
    sha256 "d5f05e487007e29e03409f9398d074e158d920d36eb82eaf66fb1136b0c5374c"
  end

  resource "subprocess32" do
    url "https://files.pythonhosted.org/packages/be/2b/beeba583e9877e64db10b52a96915afc0feabf7144dcbf2a0d0ea68bf73d/subprocess32-3.5.3.tar.gz"
    sha256 "6bc82992316eef3ccff319b5033809801c0c3372709c5f6985299c88ac7225c3"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/84/f4/5771e41fdf52aabebbadecc9381d11dea0fa34e4759b4071244fa094804c/docutils-0.14.tar.gz"
    sha256 "51e64ef2ebfb29cae1faa133b3710143496eca21c530f3f71424d77687764274"
  end

  resource "h5py" do
    url "https://files.pythonhosted.org/packages/43/27/a6e7dcb8ae20a4dbf3725321058923fec262b6f7835179d78ccc8d98deec/h5py-2.9.0.tar.gz"
    sha256 "9d41ca62daf36d6b6515ab8765e4c8c4388ee18e2a665701fef2b41563821002"
  end

  resource "mpi4py" do
    url "https://files.pythonhosted.org/packages/55/a2/c827b196070e161357b49287fa46d69f25641930fd5f854722319d431843/mpi4py-3.0.1.tar.gz"
    sha256 "6549a5b81931303baf6600fa2e3bc04d8bd1d5c82f3c21379d0d64a9abcca851"
  end

  resource "nose" do
    url "https://files.pythonhosted.org/packages/58/a5/0dc93c3ec33f4e281849523a5a913fa1eea9a3068acfa754d44d88107a44/nose-1.3.7.tar.gz"
    sha256 "f1bffef9cbc82628f6e7d7b40d7e255aefaa1adb6a1b1d26c69a8b79e6208a98"
  end

  resource "pandas" do
    url "https://files.pythonhosted.org/packages/b2/4c/b6f966ac91c5670ba4ef0b0b5613b5379e3c7abdfad4e7b89a87d73bae13/pandas-0.24.2.tar.gz"
    sha256 "4f919f409c433577a501e023943e582c57355d50a724c589e78bc1d551a535a2"
  end

  resource "seaborn" do
    url "https://files.pythonhosted.org/packages/7a/bf/04cfcfc9616cedd4b5dd24dfc40395965ea9f50c1db0d3f3e52b050f74a5/seaborn-0.9.0.tar.gz"
    sha256 "76c83f794ca320fb6b23a7c6192d5e185a5fcf4758966a0c0a54baee46d41e2f"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"
    sha256 "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"
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

    py_deps = resources.map(&:name).to_set - ["matplotlib"]
    py_deps.each do |r|
      venv.pip_install resource(r)
    end

    system "#{libexec}/bin/pip", "install", "-v", "--no-deps", "--ignore-installed", "matplotlib==2.2.4"

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
