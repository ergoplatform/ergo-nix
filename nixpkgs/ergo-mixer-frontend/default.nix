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
  pname = "ergo-mixer-frontend";
  version = "3.1.0";

  src = fetchFromGitHub {
    owner = "ergoMixer";
    repo = "ergoMixFront";
    rev = "c09a66229fa9eeb017b4581e0649fe8ef699beb7";
    sha256 = "1qpf9q1z7vw3vwyn2fnm81lhrywc5h2gmz6332ikjnjz8rlwicbd";
  };

  buildInputs = [ python2 ];
  preBuild = "export HOME=$PWD";
  extraEnvVars = {
    PYTHON = "${pkgs.python2}/bin/python"; 
  };
  npmBuild = "npm install";
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
