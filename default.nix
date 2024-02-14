{ system ? builtins.currentSystem }:
let
  sources = import ./nix/sources.nix;
  nixpkgs = import sources.nixpkgs { inherit system; };

  callPackage = nixpkgs.lib.callPackageWith (nixpkgs // pkgs);

  pkgs = {
    ecspresso = callPackage ./pkgs/ecspresso { };
    isucrud = callPackage ./pkgs/isucrud { };
    tmux-sixel = callPackage ./pkgs/tmux-sixel { };
    mitamae = callPackage ./pkgs/mitamae { };
  };
in
pkgs
