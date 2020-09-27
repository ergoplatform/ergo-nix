{ pkgs ? import <nixpkgs> {} }:
with pkgs;
rec {

	ergo-explorer-backend = callPackage ./nixpkgs/ergo-explorer-backend {};

}
