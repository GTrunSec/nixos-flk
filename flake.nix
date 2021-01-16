{
  description = "User:GTrunSec - A highly structured configuration database.";

  inputs =
    {
      # Once desired, bump master's locked revision:
      # nix flake update --update-input master
      master.url = "nixpkgs/7ff5e241a2b96fff7912b7d793a06b4374bd846c";
      nixos.url = "nixpkgs/7ff5e241a2b96fff7912b7d793a06b4374bd846c";
      stable.url = "nixpkgs/684d5d27136f154775c95005dcce2d32943c7c9e";
      home.url = "github:nix-community/home-manager/master";
      flake-utils.url = "github:numtide/flake-utils/flatten-tree-system";
      devshell.url = "github:numtide/devshell";
      nur = { url = "github:nix-community/NUR"; inputs.nixpkgs.follows = "master";};
      nixpkgs-hardenedlinux = { url = "github:hardenedlinux/nixpkgs-hardenedlinux"; flake = false;};
      photoprism-flake = { url = "github:GTrunSec/photoprism-flake"; inputs.nixpkgs.follows = "master";};
      #photoprism-flake.url = "/home/gtrun/src/photoprism-flake";
      brim-flake = { url = "github:hardenedlinux/brim-flake"; inputs.nixpkgs.follows = "master";};
      onlyoffice-desktopeditors = { url = "github:GTrunSec/onlyoffice-desktopeditors-flake"; inputs.nixpkgs.follows = "master";};
      zeek-nix = { url = "github:hardenedlinux/zeek-nix/main"; flake = false;};
      tenvideo = { url = "github:GTrunSec/Tenvideo-nix-flake"; inputs.nixpkgs.follows = "master";};
    };

  outputs = inputs@{ self, home, nixos, master, stable, devshell, flake-utils, nur, nixpkgs-hardenedlinux, photoprism-flake
                   , zeek-nix, brim-flake, onlyoffice-desktopeditors, tenvideo}:
                     let
                       inherit (builtins) attrNames attrValues elem pathExists;
                       inherit (flake-utils.lib) eachDefaultSystem mkApp flattenTreeSystem;
                       inherit (nixos) lib;
                       inherit (lib) recursiveUpdate filterAttrs mapAttrs;
                       inherit (utils) pathsToImportedAttrs genPkgset overlayPaths modules
                         genPackages pkgImport;

                       utils = import ./lib/utils.nix { inherit lib; };

                       externOverlays = [ nur.overlay devshell.overlay ];
                       externModules = [ home.nixosModules.home-manager ];

                       osSystem = "x86_64-linux";

                       outputs =
                         let
                           system = osSystem;
                           pkgset =
                             let
                               overlays =
                                 (attrValues self.overlays)
                                 ++ externOverlays
                                 ++ [ self.overlay
                                      tenvideo.overlay
                                      onlyoffice-desktopeditors.overlay
                                      brim-flake.overlay
                                      (import "${zeek-nix}/overlay.nix")
                                      (import ./pkgs/my-node-packages)
                                      (import "${nixpkgs-hardenedlinux}/nix/python-packages-overlay.nix")
                                    ];
                             in
                               genPkgset {
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
