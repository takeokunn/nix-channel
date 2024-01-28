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
    hash = "sha256-f5a684d0bf17fc9a02bfc748ca19cc160e9bba19";
  };

  vendorHash = lib.fakeHash;

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
