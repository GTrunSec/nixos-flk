{
  description = "User:GTrunSec - A highly structured configuration database.";

  inputs =
    {
      # Once desired, bump master's locked revision:
      # nix flake update --update-input master
      master.url = "nixpkgs/master";
      # => nixpkgs/release-20.09
      # Current: https://github.com/NixOS/nixpkgs/tree/nixpkgs-unstable
      nixos = { url = "nixpkgs/b702a56d417647de4090ac56c0f18bdc7e646610"; };
      stable.url = "nixpkgs/684d5d27136f154775c95005dcce2d32943c7c9e";
      home.url = "github:nix-community/home-manager/master";
      flake-utils.url = "github:numtide/flake-utils/flatten-tree-system";
      devshell.url = "github:numtide/devshell/17f46732ce299daa2977be2978f60d258c2d1b41";
      nur = { url = "github:nix-community/NUR"; inputs.nixpkgs.follows = "nixos"; };
      nixpkgs-hardenedlinux = { url = "github:hardenedlinux/nixpkgs-hardenedlinux"; flake = false; };
      photoprism-flake = { url = "github:GTrunSec/photoprism-flake"; inputs.nixpkgs.follows = "stable"; };
      #photoprism-flake.url = "/home/gtrun/src/photoprism-flake";
      brim-flake = { url = "github:hardenedlinux/brim-flake"; inputs.nixpkgs.follows = "nixos"; };
      #brim-flake = { url = "/home/gtrun/src/brim-flake"; inputs.nixpkgs.follows = "nixos";};
      #vast = { url = "/home/gtrun/src/vast"; };
      vast = { url = "github:GTrunSec/vast/nix-flake"; };

      zeek-nix = {
        url = "github:hardenedlinux/zeek-nix/main";
        inputs.nixpkgs.follows = "nixos";
      };
      tenvideo = { url = "github:GTrunSec/Tenvideo-nix-flake"; inputs.nixpkgs.follows = "nixos"; };
    };

  outputs =
    inputs@{ self
    , home
    , nixos
    , master
    , stable
    , devshell
    , flake-utils
    , nur
    , nixpkgs-hardenedlinux
    , photoprism-flake
    , vast
    , zeek-nix
    , brim-flake
    , tenvideo
    }:
    let
      inherit (builtins) attrNames attrValues elem pathExists;
      inherit (flake-utils.lib) eachDefaultSystem mkApp flattenTreeSystem;
      inherit (nixos) lib;
      inherit (lib) recursiveUpdate filterAttrs mapAttrs;
      inherit (utils) pathsToImportedAttrs genPkgset overlayPaths modules
        genPackages pkgImport;

      utils = import ./lib/utils.nix { inherit lib; };

      externOverlays = [ nur.overlay devshell.overlay ];
      externModules = [
        home.nixosModules.home-manager
        photoprism-flake.nixosModules.photoprism
        vast.nixosModules.vast
      ];

      osSystem = "x86_64-linux";

      outputs =
        let
          system = osSystem;
          pkgset =
            let
              overlays =
                (attrValues self.overlays)
                ++ externOverlays
                ++ [
                  self.overlay
                  tenvideo.overlay
                  brim-flake.overlay
                  zeek-nix.overlay
                  (import ./pkgs/my-node-packages)
                ];
            in
            genPkgset
              {
                inherit master nixos overlays system stable;
              };
        in
        {
          nixosConfigurations =
            import ./hosts (recursiveUpdate inputs {
              inherit lib pkgset utils externModules system inputs;
            });

          overlay = import ./pkgs;

          overlays = pathsToImportedAttrs overlayPaths;

          nixosModules = modules;

          templates.flk.path = ./.;

          templates.flk.description = "flk template";

          defaultTemplate = self.templates.flk;
        };
    in
    recursiveUpdate
      (eachDefaultSystem
        (system:
        let
          pkgs = pkgImport {
            inherit system;
            pkgs = nixos;
            overlays = [ devshell.overlay ];
          };

          packages = flattenTreeSystem system
            (genPackages {
              inherit self pkgs;
            });
        in
        {
          inherit packages;

          devShell = import ./shell.nix {
            inherit pkgs;
          };
        }
        )
      )
      outputs;
}
