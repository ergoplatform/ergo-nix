{ stdenv, fetchFromGitHub, rustPlatform, openssl, pkg-config, writeText }:
let
  exampleConf = writeText "example.yml" (builtins.toJSON {
    sources = [ "127.0.0.1:9052" ];
  });
in
rustPlatform.buildRustPackage rec {
  pname = "ergo-monitoring";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "SabaunT";
    repo = pname;
    rev = version;
    sha256 = "1hznmy8g389qvpjwhlwwx3jv6aqy1irmsram17vrxf8q6h9vmx6n";
  };

  cargoSha256 = "03x2vzxbzdsvg2hj1yw31avjkc6xdfbgnvdzqkkzryjn6p2w6m8c";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];
  OPENSSL_NO_VENDOR = 1;

  postInstall = ''
    mkdir -p $out/share/${pname}/examples/
    cp ${exampleConf} $out/share/${pname}/examples/
  '';
}
