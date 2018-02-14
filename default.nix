# when using nix-shell, run "configurePhase" otherwise you'll have missing headers
# to use a specific version of php, run `nix-shell --arg php '(import <nixpkgs> {}).php56'`

{ php ? (import <nixpkgs> {}).php, pkgs ? import <nixpkgs> {} }:

let
  buildPecl = import <nixpkgs/pkgs/build-support/build-pecl.nix> {
    inherit php;
    inherit (pkgs) stdenv autoreconfHook fetchurl;
  };
in

buildPecl rec {
  name = "oath-${version}";
  version = "1.0.0";
  src = ./.;
  doCheck = true;
  buildInputs = [ pkgs.oathToolkit pkgs.pkgconfig ];
  checkTarget = "test";
  checkFlagsArray = ["REPORT_EXIT_STATUS=1" "NO_INTERACTION=1" "TEST_PHP_DETAILED=1"];
}

