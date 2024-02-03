{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "mitamae";
  version = "v1.14.1";

  src = fetchurl {
    url = "https://github.com/itamae-kitchen/mitamae/releases/download/${version}/${pname}-x86_64-linux.tar.gz";
    sha256 = lib.fakeSha256;
  };

  meta = {
    description = "mitamae is a fast, simple, and single-binary configuration management tool with a DSL like Chef";
    homepage = "https://github.com/itamae-kitchen/mitamae";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}