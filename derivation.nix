{ php, stdenv, autoreconfHook, fetchurl, oathToolkit, pkgconfig,
  phpOathVersion ? null, phpOathSrc ? null, phpOathSha256 ? null }:

let
  orDefault = x: y: (if (!isNull x) then x else y);
  buildPecl = import <nixpkgs/pkgs/build-support/build-pecl.nix> {
    inherit php stdenv autoreconfHook fetchurl;
  };
in

buildPecl rec {
  pname = "oath";
  name = "oath-${version}";
  version = orDefault phpOathVersion "5bf7f88ab2644ae34e1983d698f2645d4d78308d";
  src = orDefault phpOathSrc (fetchurl {
    url = "https://github.com/jbboehr/php-oath/archive/${version}.tar.gz";
    sha256 = orDefault phpOathSha256 "0misil8s72vs5l0w6xkkfkc87spvwwrr7dnx4acci45gdx865q8m";
  });

  makeFlags = ["phpincludedir=$(out)/include/php/ext/oath"];
  buildInputs = [ oathToolkit ];
  nativeBuildInputs = [ pkgconfig ];

  doCheck = true;
  checkTarget = "test";
  checkFlagsArray = ["REPORT_EXIT_STATUS=1" "NO_INTERACTION=1" "TEST_PHP_DETAILED=1"];
}

