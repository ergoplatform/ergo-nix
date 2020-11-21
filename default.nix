{
pkgs ? import (builtins.fetchTarball {
    # NixOS 20.09 2020-11-13
    url = "https://github.com/NixOS/nixpkgs/archive/896270d629efd47d14972e96f4fbb79fc9f45c80.tar.gz";
    sha256 = "0xmjjayg19wm6cn88sh724mrsdj6mgrql6r3zc0g4x9bx4y342p7";
  }) {},
system ? builtins.currentSystem
}:

with pkgs;
rec {

  # Ergo upstream
  ergo-node = callPackage ./nixpkgs/ergo-node {};
  ergo-explorer-backend = callPackage ./nixpkgs/ergo-explorer-backend {};
  ergo-explorer-frontend = callPackage ./nixpkgs/ergo-explorer-frontend {};

  # Community packages
  ergo-monitoring = callPackage ./nixpkgs/ergo-monitoring {};
  yoroi-ergo-backend = callPackage ./nixpkgs/yoroi-ergo-backend {};

  # Integration tests
  ergo-node-test = nixosTest ./nixos/tests/ergo-node.nix;

}
