{ lib
, stdenv
, stdenvNoCC
, fetchzip
, installShellFiles
}:

let
  pname = "mitamae";
  version = "1.14.1";

  _meta = with lib; {
    description = "mitamae is a fast, simple, and single-binary configuration management tool with a DSL like Chef";
    homepage = "https://github.com/itamae-kitchen/mitamae";
    changelog = "https://github.com/itamae-kitchen/mitamae/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    platforms = platforms.darwin;
    mainProgram = "mitamae";
  };
in
{
  aarch64-darwin = stdenvNoCC.mkDerivation {
    inherit pname version;

    src = fetchzip {
      url = "https://github.com/itamae-kitchen/mitamae/releases/download/v${version}/mitamae-aarch64-darwin.tar.gz";
      hash = "sha256-CfyuWvxkeZQVuwMbX90CZF0RiY6q+o0WtfE3H9Z8q1o=";
    };

    nativeBuildInputs = [
      installShellFiles
    ];

    dontConfigure = true;
    dontBuild = true;

    meta = _meta // {
      sourceProvenance = with lib.sourceTypes; [
        binaryNativeCode
      ];
    };
  };
}.${stdenv.hostPlatform.system} or (throw "Unsupported platform ${stdenv.hostPlatform.system}")
