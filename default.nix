{
  pkgs ? import <nixpkgs> {},
  php ? pkgs.php,
  buildPecl ? pkgs.callPackage <nixpkgs/pkgs/build-support/build-pecl.nix> {
    inherit php;
  },

  phpOathVersion ? null,
  phpOathSrc ? ./.,
  phpOathSha256 ? null
}:

pkgs.callPackage ./derivation.nix {
  inherit php buildPecl phpOathVersion phpOathSrc phpOathSha256;
}

