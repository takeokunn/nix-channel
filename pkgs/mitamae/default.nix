{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "mitamae";
  version = "v1.14.1";

  src = fetchurl {
    url = "https://github.com/itamae-kitchen/mitamae/releases/download/v1.14.1/mitamae-aarch64-darwin.tar.gz";
    sha256 = "sha256-3F/oblpupG+NHe7bgSZwhxuc0GVHx75FbrrOc/g8v3s=";
  };

  meta = {
    description = "mitamae is a fast, simple, and single-binary configuration management tool with a DSL like Chef";
    homepage = "https://github.com/itamae-kitchen/mitamae";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
