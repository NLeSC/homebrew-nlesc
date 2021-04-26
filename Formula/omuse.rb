class Omuse < Formula
  include Language::Python::Virtualenv

  desc "Python virtualenv for OMUSE"
  homepage "https://github.com/omuse-geoscience/omuse/"
  url "https://github.com/omuse-geoscience/omuse.git"
  version "1.2.8"

  bottle do
    root_url "https://github.com/nlesc/homebrew-nlesc/releases/download/bottles/"
    sha256 cellar: :any, catalina: "e8448f6a9f793efb0d2105bb7f85b1fd8d2652455e1bd8daac3874c068d4736c"
  end

  netcdf = "nlesc/nlesc/netcdf-mpi"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.9"
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

  resource "amuse-framework" do
    url "https://files.pythonhosted.org/packages/dd/f6/d4d15d01cb10b5772919f5c24a637d4b16556d1bcf02457b72befd49b6cd/amuse-framework-2021.3.1.tar.gz"
    sha256 "bfd18a0a84b85e0fcc4283af24ffe2bbf300e3db60495ab4e86a7bfaebdfc3dd"
  end

  def install
    venv = virtualenv_create(libexec, "python3")

    system "#{libexec}/bin/pip", "install", "--upgrade", "pip"

    venv.pip_install resources

    cd "packages/omuse-framework" do
      system "#{libexec}/bin/python", "setup.py", "sdist"
      version = `#{libexec}/bin/python setup.py --version`
      sdist_file = "dist/omuse-framework-" + version.strip + ".tar.gz"
      system "#{libexec}/bin/pip", "install", "-v", "--no-deps", "--ignore-installed", sdist_file
    end

    version = Language::Python.major_minor_version Formula["python@3.9"].opt_bin/"python3"
    site_packages = "lib/python#{version}/site-packages"
    pth_contents = "import site; site.addsitedir('#{Formula["trilinos"].prefix/site_packages}')\n"
    (prefix/site_packages/"homebrew-trilinos.pth").write pth_contents

    inreplace "#{libexec}/bin/activate", "PS1=\"(libexec)", "PS1=\"(OMUSE)"
    bin.install_symlink "#{libexec}/bin/python" => "python-omuse"
  end

  def caveats
    s = <<EOS
Dependencies were installed in a virtualenv.
To activate and use it, run:

    . #{prefix}/libexec/bin/activate

Or add an alias to do so to your ~/.bashrc:

    alias omuse-env='. #{prefix}/libexec/bin/activate'

To deactivate, run:

    deactivate

EOS
    s
  end

  test do
    system "false"
  end
end
