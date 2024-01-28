{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "ecspresso";
  version = "2.3.2";

  src = fetchFromGitHub {
    owner = "kayac";
    repo = "ecspresso";
    rev = "refs/tags/v${version}";
    hash = lib.fakeHash;
  };

  vendorHash = lib.fakeHash;

  ldflags = [
    "-s"
    "-w"
    "-X=main.Version=v${version}"
  ];

  subPackages = ["cmd/ecspresso"];

  meta = with lib; {
    description = "A deployment tool for Amazon ECS";
    homepage = "https://github.com/kayac/ecspresso";
    license = licenses.mit;
    mainProgram = "ecspresso";
  };
}
