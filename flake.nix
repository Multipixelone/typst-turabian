{
  description = "Turabian format package for typst";
  outputs =
    {
      self,
      nixpkgs,
      devenv,
      ...
    }@inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
      ];
      imports = [
        inputs.devenv.flakeModule
      ];
      perSystem =
        {
          pkgs,
          ...
        }:
        let
          src = self;
          version = (fromTOML (builtins.readFile "${src}/typst.toml")).package.version;
          turabian = pkgs.callPackage ./packages/turabian.nix {
            inherit version src;
          };
        in
        {
          devenv.shells.default = {
            packages = [
              pkgs.typst
              pkgs.typstyle
              pkgs.git-cliff
            ];
          };

          formatter = pkgs.nixfmt-rfc-style;

          checks = {
            nixfmt = pkgs.runCommandLocal "check-nixfmt" { nativeBuildInputs = [ pkgs.nixfmt-rfc-style ]; } ''
              cd ${src}
              nixfmt --check .
              touch $out
            '';
            typstyle = pkgs.runCommandLocal "check-typstyle" { nativeBuildInputs = [ pkgs.typstyle ]; } ''
              cd ${src}
              typstyle format-all . --check
              touch $out
            '';
          };

          packages = {
            default = turabian;
            turabian = turabian;
          };
        };
    };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    devenv.url = "github:cachix/devenv";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };
}
