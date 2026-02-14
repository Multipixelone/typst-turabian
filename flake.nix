{
  description = "Turabian format package for typst";
  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
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
          # wrap package into typst
          typstWrapped = pkgs.typst.withPackages (ps: [ turabian ]);
        in
        {

          devShells.default = pkgs.mkShell {
            packages = [
              pkgs.typst
              pkgs.typstyle
              pkgs.git-cliff
            ];
            name = "turabian";
            DIRENV_LOG_FORMAT = "";
            # set env for tinymist to pickup package
            TYPST_PACKAGE_CACHE_PATH = "${typstWrapped}/lib/typst/packages";
          };

          formatter = pkgs.nixfmt;

          packages = {
            default = turabian;
            turabian = turabian;
            typst = typstWrapped;
          };
        };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };
}
