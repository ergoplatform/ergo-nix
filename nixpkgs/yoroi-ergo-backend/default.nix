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
    rev = "e79e357922d6c91f0540228fc78918d21cd24214";
    sha256 = "16ix362w5jl3qqfz72czqkh7vsd0p9h45l7c6y3bli4bn13ixxgd";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ python3 ];

  npmBuild = "npm run _flow-remove-types";

  postInstall = ''
    cp -r flow-removed $out
    makeWrapper ${nodejs-12_x}/bin/node $out/bin/${pname} --add-flags "$out/flow-removed/index.js"
  '';

}
