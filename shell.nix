{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "dev-shell";

  buildInputs = [
    pkgs.git
    pkgs.curl
    pkgs.jq
  ];

  shellHook = ''
    echo "Welcome to the development shell!"
  '';
}
