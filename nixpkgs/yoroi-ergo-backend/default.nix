{ pkgs, stdenv, fetchFromGitHub, makeWrapper, nodejs-12_x, python3 }:

let
  nix-npm-buildpackage = fetchFromGitHub {
    owner = "Emurgo";
    repo = "nix-npm-buildpackage";
    rev = "abde678d1584af0ad00477486bca26c880963a70";
    sha256 = "sha256-apHZDERTGe+kdAPVnFltIZvtoMvuqjpm5lqpII+ZfHc=";
  };

  inherit (pkgs.callPackage nix-npm-buildpackage {}) buildNpmPackage;

in buildNpmPackage rec {

  pname = "yoroi-ergo-backend";
  version = "unstable-20201231";

  src = fetchFromGitHub {
    owner = "Emurgo";
    repo = "yoroi-ergo-backend";
    rev = "289c6b07165ad403dbd26935d361a24504ac3207";
    sha256 = "13pv1bn4w7q7gpg3n7wn37k40cc3icfi4ny55kprgxbwf5sfwzxq";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ python3 ];

  npmBuild = "npm run _flow-remove-types";

  postInstall = ''
    cp -r flow-removed $out
    makeWrapper ${nodejs-12_x}/bin/node $out/bin/${pname} --add-flags "$out/flow-removed/index.js"
  '';

}
