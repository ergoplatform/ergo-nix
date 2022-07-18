{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "ergo-explorer-backend";
  version = "9.4.3";

  src = fetchurl {
    url = "https://github.com/ergoplatform/explorer-backend/releases/download/${version}/explorer-${version}.tar.gz";
    sha256 = "0i2xny940j5jvdl17c5n493snyj3pp14wi84wphc3zvzfnk8lxcw";
  };

  setSourceRoot = "sourceRoot=`pwd`";

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/share/java
    cp -v *.jar $out/share/java/
    makeWrapper ${jre}/bin/java $out/bin/ergo-chain-grabber --add-flags "-jar $out/share/java/ChainGrabber.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-explorer-api --add-flags "-jar $out/share/java/ExplorerApi.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-utx-broadcaster --add-flags "-jar $out/share/java/UtxBroadcaster.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-utx-tracker --add-flags "-jar $out/share/java/UtxTracker.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-migrator --add-flags "-jar $out/share/java/Migrator.jar"
  '';

}
