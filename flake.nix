{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs.outPath {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        packages = { inherit (pkgs) ecspresso isucrud mitamae tmux-sixel; };
      });
}
