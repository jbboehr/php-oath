{
  pkgs ? import <nixpkgs> {},
  php ? pkgs.php,

  phpOathVersion ? null,
  phpOathSrc ? ./.,
  phpOathSha256 ? null
}:

pkgs.callPackage ./derivation.nix {
  inherit php phpOathVersion phpOathSrc phpOathSha256;
}

