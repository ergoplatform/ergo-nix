{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "ergo-mixer";
  version = "3.1.0";

  src = fetchurl {
    url = "https://github.com/ergoMixer/ergoMixBack/releases/download/${version}/ergoMixer-${version}.jar";
    sha256 = "1ip5bz2ny3rs7xhmf76v1nw66qhg4qcnlz9nkcpclrf9v9h1qi47";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    makeWrapper ${jre}/bin/java $out/bin/ergo-mixer --add-flags "-jar -D\"config.file\"=\$1 $src"
  '';

}
