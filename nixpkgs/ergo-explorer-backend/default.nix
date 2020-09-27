{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "ergo-explorer-backend";
  version = "3.2.1";

  src = fetchurl {
    url = "https://github.com/ergoplatform/explorer-backend/releases/download/${version}/explorer-${version}.tar.gz";
    sha256 = "0a701gjj6b6bsjnbv7qir2xpjy59k2n8r6psr652frdaaj68m3c9";
  };

  setSourceRoot = "sourceRoot=`pwd`";

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/share/java
    cp -v *.jar $out/share/java/
    makeWrapper ${jre}/bin/java $out/bin/ergo-chain-grabber --add-flags "-jar $out/share/java/ChainGrabber-assembly-${version}.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-explorer-api --add-flags "-jar $out/share/java/ExplorerApi-assembly-${version}.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-utx-broadcaster --add-flags "-jar $out/share/java/UtxBroadcaster-assembly-${version}.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-utx-watcher --add-flags "-jar $out/share/java/UtxWatcher-assembly-${version}.jar"
  '';

}
