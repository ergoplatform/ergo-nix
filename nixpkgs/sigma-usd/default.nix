{ pkgs, stdenv, fetchFromGitHub, runtimeShell, nodePackages, python2 }:

let
  nix-npm-buildpackage = fetchFromGitHub {
    owner = "Emurgo";
    repo = "nix-npm-buildpackage";
    rev = "abde678d1584af0ad00477486bca26c880963a70";
    sha256 = "sha256-apHZDERTGe+kdAPVnFltIZvtoMvuqjpm5lqpII+ZfHc=";
  };

  inherit (pkgs.callPackage nix-npm-buildpackage {}) buildNpmPackage;

in buildNpmPackage rec {
  pname = "sigma-usd";
  version = "unstable-20200218";

  src = fetchFromGitHub {
    owner = "anon-real";
    repo = "sigma-usd";
    rev = "422a87d5a061667151c506907f312ffb7ccea3af";
    sha256 = "0jpgp56jsqgwfyqalsicihr27l0wxd724p447frkxv8yn1r207k4";
  };

  buildInputs = [ python2 ];
  preBuild = "export HOME=$PWD";
  extraEnvVars = {
    PYTHON = "${pkgs.python2}/bin/python"; 
  };
  #npmBuild = "npm install";
  buildPhase = ''
      mkdir -p $out/bin
      cat <<EOF > $out/bin/${pname}
      #!${runtimeShell}
      exec ${nodePackages.serve}/bin/serve -S -l 4600 \
           $out/public
      EOF
      chmod +x $out/bin/${pname}
  '';

}
