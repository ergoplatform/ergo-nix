{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "ergo-node";
  version = "4.0.1";

  src = fetchurl {
    url = "https://github.com/ergoplatform/ergo/releases/download/v${version}/ergo-${version}.jar";
    sha256 = "0njiqp1srzq058spzv7j4zqpmf343wsm5gfxbird82c5n79ic3gb";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    makeWrapper ${jre}/bin/java $out/bin/ergo --add-flags "-jar -Xmx3G -Dlogback.stdout.level=DEBUG $src"
  '';

}
