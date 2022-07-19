{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "ergo-node";
  version = "4.0.34";

  src = fetchurl {
    url = "https://github.com/ergoplatform/ergo/releases/download/v${version}/ergo-${version}.jar";
    sha256 = "00k7fgwzfzc5bj19rnx3dc905wb5nnavwn3bfl956x2kmyhy6p2l";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    makeWrapper ${jre}/bin/java $out/bin/ergo --add-flags "-jar -Xmx3G -Dlogback.stdout.level=DEBUG $src"
  '';

}
