{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "zk-treasury-server";
  version = "0.2";

  src = fetchurl {
    url = "https://github.com/anon-real/DistributedSigsServer/releases/download/v${version}/ZKTreasury-server-${version}.jar";
    sha256 = "0zdvxbj2r1bhczxka1k9yqibddpn2rfimybhi2kcpgpmgsqk6sk7";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    makeWrapper ${jre}/bin/java $out/bin/${pname} --add-flags "-jar $src"
  '';

}
