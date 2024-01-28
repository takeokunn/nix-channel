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
    hash = "sha256-RrXu1yjjBWniow9ugM4H/rER0yemaceT8v30dc2QCOg=";
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
