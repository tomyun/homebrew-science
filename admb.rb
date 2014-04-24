require "formula"

class Admb < Formula
  homepage "http://www.admb-project.org/"
  url "http://admb-project.googlecode.com/files/admb-11.1.zip"
  sha1 "d728712cbf9b123e5339b9e77f806c7c49cc3086"

  patch :DATA

  def install
    ENV.deparallelize

    system "make"

    bin.install ["admb", "adcomp", "adlink", "tpl2cpp", "tpl2rem"].map { |name| "build/dist/bin/" + name }
    include.install Dir["build/dist/include/*"] 
    lib.install Dir["build/dist/lib/*"]

    (prefix+"contrib/bin").install Dir["build/dist/contrib/bin/*"]
    (prefix+"contrib/include").install Dir["build/dist/contrib/include/*"]
    (prefix+"contrib/lib").install Dir["build/dist/contrib/lib/*"]
  end

  def caveats; <<-EOS.undent
    You may need to set up a shell varaible:
      export ADMB_HOME=#{bin}
    EOS
  end
end

__END__
diff --git a/src/linad99/ufstream.cpp b/src/linad99/ufstream.cpp
index 51522dc..d572584 100644
--- a/src/linad99/ufstream.cpp
+++ b/src/linad99/ufstream.cpp
@@ -38,7 +38,7 @@ uistream& uistream::operator>> (const TYPE& x) \
 #if defined(__TURBOC__) || defined(__GNUDOS__) || defined(__MSVC32__) || defined (__WAT32__)
 uostream::uostream(const char* name, int  m, int prot)
 #  if defined(__GNU_NEWER__)
-    :ofstream(name, std::ios::binary | std::_Ios_Openmode(m)) 
+    :ofstream(name, std::ios::binary | std::ios_base::openmode(m)) 
 #  elif defined(__MSC_NEWER__) || (__BORLANDC__  > 0x0550) 
     :ofstream(name, std::ios::binary | m) 
 #  else
@@ -80,7 +80,7 @@ void uostream::open(const char* name, int m, int prot)
 #else
 #  if defined(linux)
 #    if (__GNUC__  >= 3) 
-       ofstream::open(name, std::_Ios_Openmode(m));
+       ofstream::open(name, std::ios_base::openmode(m));
 #    else
        ofstream::open(name, m);
 #    endif     
diff --git a/src/tools99/cifstrem.cpp b/src/tools99/cifstrem.cpp
index 4c2106e..c666d46 100755
--- a/src/tools99/cifstrem.cpp
+++ b/src/tools99/cifstrem.cpp
@@ -82,7 +82,7 @@ cifstream::cifstream(const char* fn, int open_m, char cc)
  #if defined(__SUNPRO_CC)
  : ifstream(fn, ios::in | open_m) , file_name(fn)
  #else
- : ifstream(fn, ios::in | std::_Ios_Openmode(open_m)) , file_name(fn)
+ : ifstream(fn, ios::in | std::ios_base::openmode(open_m)) , file_name(fn)
  #endif
 #elif defined (__ZTC__)
  : ios(&buffer), ifstream(fn, ios::in | open_m) , file_name(fn)
