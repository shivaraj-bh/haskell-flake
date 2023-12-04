{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [ 
        inputs.haskell-flake.flakeModule 
        inputs.pre-commit-hooks-nix.flakeModule
      ];

      perSystem = { self', pkgs, ... }: {
        imports = [ ./nix/pre-commit.nix ];
      	haskellProjects.default = { };
        # haskell-flake doesn't set the default package, but you can do it here.
        packages.default = self'.packages.bar;
      };
    };
}
