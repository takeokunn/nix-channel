{ callPackage, python310, lib, stdenv, openssl, enableNpm ? true }:
let
  buildNodejs = callPackage <nixpkgs/pkgs/development/web/nodejs/nodejs.nix> {
    inherit openssl;
    python = python310;
  };
in
  buildNodejs {
    inherit enableNpm;
    version = "14.21.3";
    sha256 = "sha256-RY7AkuYK1wDdzwectj1DXBXaTHuz0/mbmo5YqZ5UB14=";
    # patches = lib.optional stdenv.isDarwin ./bypass-xcodebuild.diff;
  }
