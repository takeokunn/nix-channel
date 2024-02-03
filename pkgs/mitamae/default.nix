{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "mitamae";
  version = "v1.14.1";

  src = fetchurl {
    url = "https://github.com/itamae-kitchen/mitamae/releases/download/v1.14.1/mitamae-aarch64-darwin.tar.gz";
    sha256 = "sha256-r+Gh3XZkFNYQ/T8Fpo19Ij5gwpP003e37Ead1huihVI=";
  };

  meta = {
    description = "mitamae is a fast, simple, and single-binary configuration management tool with a DSL like Chef";
    homepage = "https://github.com/itamae-kitchen/mitamae";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
