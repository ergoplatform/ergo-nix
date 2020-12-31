{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "ergo-explorer-backend";
  version = "5.1.0";

  src = fetchurl {
    url = "https://github.com/ergoplatform/explorer-backend/releases/download/${version}/explorer-${version}.tar.gz";
    sha256 = "1m14ijvk586hz6xp7waxm0h0mh84bh4rnzznp6xamd1zibv7vdxs";
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
