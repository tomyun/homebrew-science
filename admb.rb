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
    prefix.install Dir["build/dist/*"]
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
