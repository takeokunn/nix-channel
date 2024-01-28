{ lib
,buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "isucrud";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "mazrean";
    repo = "isucrud";
    rev = "refs/tags/v${version}";
    hash = "sha256-MXRxR9LBlrUpjHevu1f/xHJ0dU4syM2Ue30pnt5F7+U=";
  };

  vendorHash = "sha256-MXRxR9LBlrUpjHevu1f/xHJ0dU4syM2Ue30pnt5F7+U=";

  ldflags = [
    "-s"
    "-w"
    "-X=main.Version=v${version}"
  ];

  meta = {
    description = "ISUCON用DBへのCRUDへのデータフロー可視化ツール";
    homepage = "https://github.com/mazrean/isucrud";
    mainProgram = "isucrud";
  };
}
