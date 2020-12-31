{
pkgs ? import (builtins.fetchTarball {
    # NixOS 20.09 2020-12-24
    url = "https://github.com/NixOS/nixpkgs/archive/a3a3dda3bacf61e8a39258a0ed9c924eeca8e293.tar.gz";
    sha256 = "1ahn3srby9rjh7019b26n4rb4926di1lqdrclxfy2ff7nlf0yhd5";
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
