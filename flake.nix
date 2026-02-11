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
          mkDate =
            longDate:
            with builtins;
            (concatStringsSep "-" [
              (substring 0 4 longDate)
              (substring 4 2 longDate)
              (substring 6 2 longDate)
            ]);
          version = mkDate (self.lastModifiedDate or "19700101");
          src = self;
          datesFile =
            if builtins.pathExists (self + "/essay-dates.txt") then self + "/essay-dates.txt" else null;

          papers = pkgs.callPackage ./packages/papers.nix {
            inherit version src datesFile;
          };
        in
        {
          devenv.shells.default = {
            packages = [
              pkgs.typst
            ];
          };

          packages = {
            default = papers;
            papers = papers;
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
