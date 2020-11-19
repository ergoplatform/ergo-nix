{
  pkgs,
  ergoNixPkgs ? import (../..) {},
  system ?  builtins.currentSystem
}:

with import (pkgs.path + "/nixos/lib/testing-python.nix") { inherit system; };

rec {
  name = "ergo-node-test";
   machine = {
      imports = [
        ../ergo-node.nix
      ];
      environment.systemPackages = [ ergoNixPkgs.ergo-node ];
      services.ergo-node.enable = true;
      services.ergo.api.keyHash = "324dcf027dd4a30a932c441f365a25e86b173defa4b8e58948253471b81b72cf";
   };

    testScript = ''
      machine.start()
      machine.wait_for_unit("ergo-node")
      machine.succeed("find /var/lib/ergo")
    '';

}