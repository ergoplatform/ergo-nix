{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "ergo-assembler";
  version = "1.0";

  src = fetchurl {
    url = "https://github.com/anon-real/ergo-assembler/releases/download/v${version}/${pname}-${version}.jar";
    sha256 = "18lfppgv8x1hi4hx458xpy4l29aigmab8pa0aczcbxgabbmzjphd";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    makeWrapper ${jre}/bin/java $out/bin/${pname} --add-flags "-jar $src"
  '';

}
