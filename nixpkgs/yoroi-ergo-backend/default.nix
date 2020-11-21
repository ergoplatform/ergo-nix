{ pkgs, stdenv, fetchFromGitHub, makeWrapper, nodejs-12_x }:

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
  version = "unstable-20201121";

  src = fetchFromGitHub {
    owner = "Emurgo";
    repo = "yoroi-ergo-backend";
    rev = "373c3a1e28becc6739bba244f09c1a1597c2e5c4";
    sha256 = "1l6jyadghmfsl9wjr5zr814a7baai6pgvws8gjagxnws8vp9ggz7";
  };

  nativeBuildInputs = [ makeWrapper ];

  npmBuild = "npm run _flow-remove-types";

  postInstall = ''
    cp -r flow-removed $out
    makeWrapper ${nodejs-12_x}/bin/node $out/bin/${pname} --add-flags "$out/flow-removed/index.js"
  '';

}
