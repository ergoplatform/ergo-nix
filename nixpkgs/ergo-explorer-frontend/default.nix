{ stdenv, runtimeShell, mkYarnPackage, fetchFromGitHub, nodePackages, nodejs-12_x, yarn }:

mkYarnPackage rec {
  pname = "ergo-explorer-frontend";
  version = "unstable-20201008";

  src = fetchFromGitHub {
    owner = "ergoplatform";
    repo = "explorer-frontend";
    rev = "5cfe75855eb6e1ea22f14380cf9f86e271a430fd";
    sha256 = "0v0lybs7zd535r5mrmdjwiy13ip5qs6w7zxhbsypqfljhc2iyj4i";
  };

  buildInputs = [ runtimeShell nodejs-12_x yarn nodePackages.serve ];

  buildPhase = ''
      mkdir -p $out/bin
      cat <<EOF > $out/bin/${pname}
      #!${runtimeShell}
      exec ${nodePackages.serve}/bin/serve -l 5000 \
           $out/libexec/blockchain-explorer/node_modules/blockchain-explorer/build/
      EOF
      chmod +x $out/bin/${pname}
  '';

}
