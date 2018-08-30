{ stdenv
, zlib
, pkgconfig
, python2
, mercurial
, readline
, gcc }:

stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "qctool";
  version = "2.0.1";

  src = fetchMercurial {
    url = "https://bitbucket.org/gavinband/qctool";
    rev = "ba5eaa44a62f";
  };

  buildInputs = [ gcc zlib python2 mercurial readline ];

  configurePhase = "${python2.interpreter} waf-1.5.18 configure --prefix=$out";

  buildPhase = "${python2.interpreter} waf-1.5.18";

  installPhase = ''
    ${python2.interpreter} waf-1.5.18 install
  '';

  meta = with stdenv.lib; {
    description = "A command-line utility program for manipulation and quality control of gwas datasets and other genome-wide data";
    license = licenses.boost;
    homepage = "http://www.well.ox.ac.uk/~gav/qctool/index.html";
    maintainers = [ maintainers.helkafen ];
  };
}
