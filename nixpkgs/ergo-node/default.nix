{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "ergo-node";
  version = "3.3.7";

  src = fetchurl {
    url = "https://github.com/ergoplatform/ergo/releases/download/v${version}/ergo-${version}.jar";
    sha256 = "11gb372js4ybyxasi842ia34qlhkyn7xndi1dk3kpdd8g1jb8n1m";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    makeWrapper ${jre}/bin/java $out/bin/ergo --add-flags "-jar -Xmx3G -Dlogback.stdout.level=DEBUG $src"
  '';

}
