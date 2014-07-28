require "formula"

class Admb < Formula
  homepage "http://www.admb-project.org/"
  url "https://admb-project.googlecode.com/files/admb-11.1.zip"
  sha1 "d728712cbf9b123e5339b9e77f806c7c49cc3086"

  def install
    ENV.deparallelize

    ["src/linad99/ufstream.cpp", "src/tools99/cifstrem.cpp"].each do |f|
      inreplace f, "std::_Ios_Openmode", "std::ios::openmode"
    end

    system "make"
    bin.install ["admb", "adcomp", "adlink", "tpl2cpp", "tpl2rem"].map { |name| "build/dist/bin/" + name }
    include.install Dir["build/dist/include/*"]
    lib.install Dir["build/dist/lib/*"]
    (prefix+"contrib/bin").install Dir["build/dist/contrib/bin/*"]
    (prefix+"contrib/include").install Dir["build/dist/contrib/include/*"]
    (prefix+"contrib/lib").install Dir["build/dist/contrib/lib/*"]
  end

  test do
    system "admb"
  end

  def caveats; <<-EOS.undent
    You may need to set up a shell varaible:
      export ADMB_HOME=#{bin}
    EOS
  end
end
