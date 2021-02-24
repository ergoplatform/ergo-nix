{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "ergo-explorer-backend";
  version = "7.0.2";

  src = fetchurl {
    url = "https://github.com/ergoplatform/explorer-backend/releases/download/${version}/explorer-${version}.tar.gz";
    sha256 = "Vm/bZWNUH8w9A6S6suahwEgZ1cOtdIKor3VS7ctu3F8=";
  };

  setSourceRoot = "sourceRoot=`pwd`";

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/share/java
    cp -v *.jar $out/share/java/
    makeWrapper ${jre}/bin/java $out/bin/ergo-chain-grabber --add-flags "-jar $out/share/java/ChainGrabber-${version}.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-explorer-api --add-flags "-jar $out/share/java/ExplorerApi-${version}.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-utx-broadcaster --add-flags "-jar $out/share/java/UtxBroadcaster-${version}.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-utx-tracker --add-flags "-jar $out/share/java/UtxTracker-${version}.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-migrator --add-flags "-jar $out/share/java/Migrator-${version}.jar"
  '';

}
