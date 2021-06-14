class Omuse < Formula
  include Language::Python::Virtualenv

  desc "Python virtualenv for OMUSE"
  homepage "https://github.com/omuse-geoscience/omuse/"
  url "https://github.com/omuse-geoscience/omuse.git", :tag => "v2021.6.0"

  bottle do
    root_url "https://github.com/nlesc/homebrew-nlesc/releases/download/bottles/"
    rebuild 1
    sha256 cellar: :any, catalina: "f57a5cb2b7259945a24be6ecfa211e96d4d2dab6c76d0462f7b487afae7ca8e0"
  end

  netcdf = "nlesc/nlesc/netcdf-mpi"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.9"
  depends_on "freetype"
  depends_on "gcc" # for gfortran
  depends_on "numpy"
  depends_on "scipy"
  depends_on "open-mpi"
  depends_on "fftw"
  depends_on "gsl"
  depends_on "hdf5-mpi"
  depends_on netcdf

  # Python dependencies
  resource "wheel" do
    url "https://files.pythonhosted.org/packages/ed/46/e298a50dde405e1c202e316fa6a3015ff9288423661d7ea5e8f22f589071/wheel-0.36.2.tar.gz"
    sha256 "e11eefd162658ea59a60a0f6c7d493a7190ea4b9a85e335b33489d9f17e0245e"
  end

  resource "setuptools" do
    url "https://files.pythonhosted.org/packages/f6/e9/19af16328705915233299f6f1f02db95899fb00c75ac9da4757aa1e5d1de/setuptools-56.0.0.tar.gz"
    sha256 "08a1c0f99455307c48690f00d5c2ac2c1ccfab04df00454fef854ec145b81302"
  end

  resource "setuptools_scm" do
    url "https://files.pythonhosted.org/packages/57/38/930b1241372a9f266a7df2b184fb9d4f497c2cef2e016b014f82f541fe7c/setuptools_scm-6.0.1.tar.gz"
    sha256 "d1925a69cb07e9b29416a275b9fadb009a23c148ace905b2fb220649a6c18e92"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/f0/cb/80a4a274df7da7b8baf083249b0890a0579374c3d74b5ac0ee9291f912dc/attrs-20.3.0.tar.gz"
    sha256 "832aa3cde19744e49938b91fea06d69ecb9e649c93ba974535d08ad92164f700"
  end

  resource "cftime" do
    url "https://files.pythonhosted.org/packages/9d/c3/80dd52e4cadb4ae60ea957fa5aa3f45b6678294d96d66f7759f745573f8e/cftime-1.4.1.tar.gz"
    sha256 "7c55540bc164746c3c4f86a07c9c7b9ed4dfb0b0d988348ec63cec065c58766d"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/4c/17/559b4d020f4b46e0287a2eddf2d8ebf76318fd3bd495f1625414b052fdc9/docutils-0.17.1.tar.gz"
    sha256 "686577d2e4c32380bb50cbb22f575ed742d58168cee37e99117a854bcd88f125"
  end

  resource "f90nml" do
    url "https://files.pythonhosted.org/packages/f3/d8/cc11f06c69b6fa69b5ed824b0d0f20ee0bf539e94f52a3aca0cbc73268de/f90nml-1.2.tar.gz"
    sha256 "07fbb9101f218ce89ccc34264ec81116edc9ed0ab69ad1cd8316f19ea694cd2e"
  end

  resource "h5py" do
    url "https://files.pythonhosted.org/packages/ea/00/d0606cc0d6107a98f75b98367dc42917a67e3a7ec881636835f8e6987e6b/h5py-3.2.1.tar.gz"
    sha256 "89474be911bfcdb34cbf0d98b8ec48b578c27a89fdb1ae4ee7513f1ef8d9249e"
  end

  resource "iniconfig" do
    url "https://files.pythonhosted.org/packages/23/a2/97899f6bd0e873fed3a7e67ae8d3a08b21799430fb4da15cfedf10d6e2c2/iniconfig-1.1.1.tar.gz"
    sha256 "bc3af051d7d14b2ee5ef9969666def0cd1a000e121eaea580d4a313df4b37f32"
  end

  resource "mpi4py" do
    url "https://files.pythonhosted.org/packages/ec/8f/bbd8de5ba566dd77e408d8136e2bab7fdf2b97ce06cab830ba8b50a2f588/mpi4py-3.0.3.tar.gz"
    sha256 "012d716c8b9ed1e513fcc4b18e5af16a8791f51e6d1716baccf988ad355c5a1f"
  end

  resource "netCDF4" do
    url "https://files.pythonhosted.org/packages/79/0d/caa957cc1b42b718ce4b9b3e849e6f7aa99faad2d522d8f2d7a33500fba0/netCDF4-1.5.6.tar.gz"
    sha256 "7577f4656af8431b2fa6b6797acb45f81fa1890120e9123b3645e14765da5a7c"
  end

  resource "nose" do
    url "https://files.pythonhosted.org/packages/58/a5/0dc93c3ec33f4e281849523a5a913fa1eea9a3068acfa754d44d88107a44/nose-1.3.7.tar.gz"
    sha256 "f1bffef9cbc82628f6e7d7b40d7e255aefaa1adb6a1b1d26c69a8b79e6208a98"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/86/3c/bcd09ec5df7123abcf695009221a52f90438d877a2f1499453c6938f5728/packaging-20.9.tar.gz"
    sha256 "5b327ac1320dc863dca72f4514ecc086f31186744b84a230374cc1fd776feae5"
  end

  resource "pluggy" do
    url "https://files.pythonhosted.org/packages/f8/04/7a8542bed4b16a65c2714bf76cf5a0b026157da7f75e87cc88774aa10b14/pluggy-0.13.1.tar.gz"
    sha256 "15b2acde666561e1298d71b523007ed7364de07029219b604cf808bfa1c765b0"
  end

  resource "py" do
    url "https://files.pythonhosted.org/packages/0d/8c/50e9f3999419bb7d9639c37e83fa9cdcf0f601a9d407162d6c37ad60be71/py-1.10.0.tar.gz"
    sha256 "21b81bda15b66ef5e1a777a21c4dcd9c20ad3efd0b3f817e7a809035269e1bd3"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/c1/47/dfc9c342c9842bbe0036c7f763d2d6686bcf5eb1808ba3e170afdb282210/pyparsing-2.4.7.tar.gz"
    sha256 "c203ec8783bf771a155b207279b9bccb8dea02d8f0c9e5f8ead507bc3246ecc1"
  end

  resource "pytest" do
    url "https://files.pythonhosted.org/packages/9e/1f/226f5c2393701c87c315b6d6cdb65ec1cbc9008e7a9ccb1d31ab79e0c19b/pytest-6.2.3.tar.gz"
    sha256 "671238a46e4df0f3498d1c3270e5deb9b32d25134c99b7d75370a68cfbe9b634"
  end

  resource "toml" do
    url "https://files.pythonhosted.org/packages/be/ba/1f744cdc819428fc6b5084ec34d9b30660f6f9daaf70eead706e3203ec3c/toml-0.10.2.tar.gz"
    sha256 "b3bda1d108d5dd99f4a20d24d9c348e91c4db7ab1b749200bded2f839ccbe68f"
  end
  resource "Cycler" do
    url "https://files.pythonhosted.org/packages/c2/4b/137dea450d6e1e3d474e1d873cd1d4f7d3beed7e0dc973b06e8e10d32488/cycler-0.10.0.tar.gz"
    sha256 "cd7b2d1018258d7247a71425e9f26463dfb444d411c39569972f4ce586b0c9d8"
  end

  resource "kiwisolver" do
    url "https://files.pythonhosted.org/packages/90/55/399ab9f2e171047d28933ae4b686d9382d17e6c09a01bead4a6f6b5038f4/kiwisolver-1.3.1.tar.gz"
    sha256 "950a199911a8d94683a6b10321f9345d5a3a8433ec58b217ace979e18f16e248"
  end

  resource "Pillow" do
    url "https://files.pythonhosted.org/packages/21/23/af6bac2a601be6670064a817273d4190b79df6f74d8012926a39bc7aa77f/Pillow-8.2.0.tar.gz"
    sha256 "a787ab10d7bb5494e5f76536ac460741788f1fbce851068d73a87ca7c35fc3e1"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/be/ed/5bbc91f03fa4c839c4c7360375da77f9659af5f7086b7a7bdda65771c8e0/python-dateutil-2.8.1.tar.gz"
    sha256 "73ebfe9dbf22e832286dafa60473e4cd239f8592f699aa5adaf10050e6e1823c"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "matplotlib" do
    url "https://files.pythonhosted.org/packages/60/d3/286925802edaeb0b8834425ad97c9564ff679eb4208a184533969aa5fc29/matplotlib-3.4.2.tar.gz"
    sha256 "d8d994cefdff9aaba45166eb3de4f5211adb4accac85cbf97137e98f26ea0219"
  end

  resource "amuse-framework" do
    url "https://files.pythonhosted.org/packages/dd/f6/d4d15d01cb10b5772919f5c24a637d4b16556d1bcf02457b72befd49b6cd/amuse-framework-2021.3.1.tar.gz"
    sha256 "bfd18a0a84b85e0fcc4283af24ffe2bbf300e3db60495ab4e86a7bfaebdfc3dd"
  end

  patch <<-END_PYTHON_OMUSE_PATCH
--- a/python-omuse   2021-06-09 17:49:49.000000000 +0100
+++ b/python-omuse   2021-06-09 17:49:37.000000000 +0100
@@ -0,0 +1,2 @@
+#!/usr/bin/env sh
+exec LIBEXEC/bin/python "$@"
END_PYTHON_OMUSE_PATCH

  patch <<-END_OMUSE_MODULE_PATCH
--- a/src/omuse/__init__.py   2021-06-09 17:49:49.000000000 +0100
+++ b/src/omuse/__init__.py   2021-06-09 17:49:37.000000000 +0100
@@ -0,0 +1,1 @@
+__path__ = __import__('pkgutil').extend_path(__path__, __name__)
END_OMUSE_MODULE_PATCH

  patch <<-END_OMUSE_COMMUNITY_MODULE_PATCH
--- a/src/omuse/community/__init__.py   2021-06-09 17:49:49.000000000 +0100
+++ b/src/omuse/community/__init__.py   2021-06-09 17:49:37.000000000 +0100
@@ -0,0 +1,1 @@
+__path__ = __import__('pkgutil').extend_path(__path__, __name__)
END_OMUSE_COMMUNITY_MODULE_PATCH

  patch <<-END_OMUSE_ENV_PATCH
--- a/omuse-env   2021-06-09 17:49:49.000000000 +0100
+++ b/omuse-env   2021-06-09 17:49:37.000000000 +0100
@@ -0,0 +1,8 @@
+#!/usr/bin/env sh
+if [ "$#" -ne 1 ]; then
+    printf "Usage:\\n"
+    printf "omuse-env DIR"
+    exit 1
+fi
+LIBEXEC/bin/python -m venv "$1" || exit 1
+printf "import site; site.addsitedir('LIBEXEC/SITE_PACKAGES')\\n" >"$1"/SITE_PACKAGES/omuse.pth
END_OMUSE_ENV_PATCH

  def install
    venv = virtualenv_create(libexec, "python3")

    system "#{libexec}/bin/pip", "install", "--upgrade", "pip"

    venv.pip_install resources

    cd "packages/omuse-framework" do
      system "#{libexec}/bin/python", "setup.py", "sdist"
      version = `#{libexec}/bin/python setup.py --version`
      version = version[0, version.index("\n")]
      sdist_file = "dist/omuse-framework-" + version + ".tar.gz"
      system "#{libexec}/bin/pip", "install", "-v", "--no-deps", "--ignore-installed", sdist_file
    end

    py_version = Language::Python.major_minor_version Formula["python@3.9"].opt_bin/"python3"
    site_packages = "lib/python#{py_version}/site-packages"

    (libexec/site_packages/"omuse.pth").write <<EOS
import glob; [addsitedir(p) for p in  glob.iglob('/usr/local/opt/omuse-*/libexec/lib/python3.9/site-packages')]
EOS

    inreplace "#{libexec}/bin/activate", "PS1=\"(libexec)", "PS1=\"(OMUSE)"

    inreplace "python-omuse", "LIBEXEC", "#{libexec}"

    inreplace "omuse-env", "SITE_PACKAGES", "#{site_packages}"
    inreplace "omuse-env", "LIBEXEC", "#{libexec}"

    chmod 0755, "python-omuse"
    bin.install "python-omuse"

    chmod 0755, "omuse-env"
    bin.install "omuse-env"
  end

  def caveats
    s = <<EOS
Dependencies were installed in a virtualenv.
To start a python interpreter with omuse's packages accessible, run:

    python-omuse

For scripts, use the following shebang at the start:

    #!/usr/bin/env python-omuse

Alternatively, you can create a virtualenv including omuse using:

    omuse-env <DIR>

To activate, run:

    . <DIR>/bin/activate

To deactivate, run:

    deactivate

EOS
    s
  end

  test do
    system "false"
  end
end
