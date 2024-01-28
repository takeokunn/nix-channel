{ system ? builtins.currentSystem }:
let
  sources = import ./nix/sources.nix;
  nixpkgs = import sources.nixpkgs { inherit system; };

  callPackage = nixpkgs.lib.callPackageWith (nixpkgs // pkgs);

  pkgs = {
    ecspresso = callPackage ./pkgs/ecspresso { };
    isucrud = callPackage ./pkgs/isucrud { };
  };
in
pkgs
