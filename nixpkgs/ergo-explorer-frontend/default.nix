{ pkgs, stdenv, runtimeShell, mkYarnPackage, fetchFromGitHub, nodePackages, nodejs-12_x, yarn }:
let
  # We assume this package is always used to connect to the local backends
  # and not to upstream
  frontend-config = pkgs.writeText "ergo-explorer-frontend-config.js" ''
var __APP_CONFIG__ = {
  apiUrl: 'http://localhost:8080/api/v0',
  alternativeLogo: true,
  environments: [
    {
      name: 'Mainnet local',
      url: 'http://localhost:5000',
    },
   ],
};

if (typeof global !== 'undefined') {
  global.__APP_CONFIG__ = __APP_CONFIG__;
}'';
in

mkYarnPackage rec {
  pname = "ergo-explorer-frontend";
  version = "unstable-20201008";

  src = fetchFromGitHub {
    owner = "ergoplatform";
    repo = "explorer-frontend";
    rev = "e1dfee2b36d45db31986c0af2d115b7ca7cd55c7";
    sha256 = "013b54x5gswmnsy7vjr23z7bkqinbgcg5mbc9lsaa67v9pimgvkw";
  };

  buildInputs = [ runtimeShell nodejs-12_x yarn nodePackages.serve ];

  buildPhase = ''
      mkdir -p $out/bin
      cat <<EOF > $out/bin/${pname}
      #!${runtimeShell}
      exec ${nodePackages.serve}/bin/serve -S -l 5000 \
           $out/libexec/blockchain-explorer/node_modules/blockchain-explorer/build/
      EOF
      chmod +x $out/bin/${pname}
  '';
  postInstall = ''
    mkdir -p $out/libexec/blockchain-explorer/node_modules/blockchain-explorer/build/config/
    cp -v ${frontend-config} $out/libexec/blockchain-explorer/node_modules/blockchain-explorer/build/config/app.config.js
  '';


}
