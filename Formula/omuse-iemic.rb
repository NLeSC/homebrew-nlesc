class OmuseIemic < Formula
  include Language::Python::Virtualenv

  desc "I-EMIC package for OMUSE"
  homepage "https://github.com/omuse-geoscience/omuse/"
  url "https://github.com/omuse-geoscience/omuse.git", :tag => "v2021.6.0"

  bottle do
    root_url "https://github.com/nlesc/homebrew-nlesc/releases/download/bottles/"
    sha256 cellar: :any, catalina: "18ff03bbcf72cd877b3fc09e92ba44ade7a21262611de2ec95e0691c5b8f3e24"
  end

  omuse = "nlesc/nlesc/omuse"
  trilinos = "nlesc/nlesc/trilinos"

  depends_on "cmake" => :build
  depends_on omuse
  depends_on trilinos

  patch <<-END_OMUSE_INIT_PATCH
--- a/__init__.py   2021-06-09 17:49:49.000000000 +0100
+++ b/__init__.py   2021-06-09 17:49:37.000000000 +0100
@@ -0,0 +1,1 @@
+__path__ = __import__('pkgutil').extend_path(__path__, __name__)
END_OMUSE_INIT_PATCH

  patch <<-END_OMUSE_COMMUNITY_INIT_PATCH
--- a/community/__init__.py   2021-06-09 17:49:49.000000000 +0100
+++ b/community/__init__.py   2021-06-09 17:49:37.000000000 +0100
@@ -0,0 +1,1 @@
+__path__ = __import__('pkgutil').extend_path(__path__, __name__)
END_OMUSE_COMMUNITY_INIT_PATCH

  def install
    virtualenv_create(libexec, "python3")

    system "#{libexec}/bin/pip", "install", "--upgrade", "pip"

    version = Language::Python.major_minor_version Formula["python@3.9"].opt_bin/"python3"
    site_packages = "lib/python#{version}/site-packages"
    pth_contents = "import site; site.addsitedir('#{Formula["omuse"].libexec/site_packages}')\n"
    (libexec/site_packages/"homebrew-omuse.pth").write pth_contents

    cd "src/omuse/community/iemic" do
      ENV.append_path "PATH", "#{libexec}/bin/"
      system "make", "DOWNLOAD_CODES=1", "download"
    end

    cd "packages/omuse-iemic" do
      system "#{libexec}/bin/python", "setup.py", "sdist"
      version = `#{libexec}/bin/python setup.py --version`
      version = version[0, version.index("\n")]
      sdist_file = "dist/omuse-iemic-" + version + ".tar.gz"
      system "#{libexec}/bin/pip", "install", "-v", "--no-deps", "--ignore-installed", sdist_file
    end

    rm (libexec/site_packages/"homebrew-omuse.pth")
    (libexec/site_packages/"omuse").install "__init__.py"
    (libexec/site_packages/"omuse"/"community").install "community/__init__.py"
  end

  def caveats
    s = <<EOS
Dependencies were installed in a virtualenv.
To start a python interpreter with omuse's packages accessible, run:

    python-omuse

For scripts, use the following shebang at the start:

    #!/usr/bin/env python-omuse

Alternatively, you can manually activate the virtualenv using:

    . #{Formula["omuse"].prefix}/libexec/bin/activate

To deactivate, run:

    deactivate
EOS
    s
  end

  test do
    system "false"
  end
end
