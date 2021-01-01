{
  description = "User:GTrunSec - A highly structured configuration database.";

  inputs =
    {
      master.url = "nixpkgs/7ff5e241a2b96fff7912b7d793a06b4374bd846c";
      stable.url = "nixpkgs/684d5d27136f154775c95005dcce2d32943c7c9e";
      nixos.url = "nixpkgs/7ff5e241a2b96fff7912b7d793a06b4374bd846c";
      home.url = "github:rycee/home-manager/bqv-flakes";
      nixpkgs-hardenedlinux = { url = "github:hardenedlinux/nixpkgs-hardenedlinux"; flake = false;};
      photoprism-flake.url = "github:GTrunSec/photoprism-flake";
      #photoprism-flake.url = "/home/gtrun/src/photoprism-flake";
      brim-flake.url = "github:hardenedlinux/brim-flake";
      onlyoffice-desktopeditors.url = "github:GTrunSec/onlyoffice-desktopeditors-flake";
      zeek-nix = { url = "github:hardenedlinux/zeek-nix/main"; flake = false;};
      tenvideo.url = "github:GTrunSec/Tenvideo-nix-flake";
    };

  outputs = inputs@{ self, home, nixos, master, stable, nixpkgs-hardenedlinux, photoprism-flake
                   , zeek-nix, brim-flake, onlyoffice-desktopeditors, tenvideo}:
    let
      inherit (builtins) attrNames attrValues readDir;
      inherit (nixos) lib;
      inherit (lib) removeSuffix recursiveUpdate genAttrs filterAttrs;
      inherit (utils) pathsToImportedAttrs;

      utils = import ./lib/utils.nix { inherit lib; };

      system = "x86_64-linux";

      pkgImport = pkgs:
        import pkgs {
          inherit system;
          overlays = attrValues self.overlays
                     ++ [ (import ./pkgs/my-node-packages)
                          (import "${nixpkgs-hardenedlinux}/nix/python-packages-overlay.nix")
                          #nuclear-flake.overlay
                          tenvideo.overlay
                          onlyoffice-desktopeditors.overlay
                          brim-flake.overlay
                          (import "${zeek-nix}/overlay.nix")
                        ];
          config = { allowUnfree = true; };
        };

      pkgset = {
        osPkgs = pkgImport nixos;
        pkgs = pkgImport master;
        stable = pkgImport stable;
      };

    in
    with pkgset;
    {
      nixosConfigurations =
        import ./hosts (recursiveUpdate inputs {
          inherit lib pkgset system utils;
        }
        );

      devShell."${system}" = import ./shell.nix {
        inherit pkgs;
      };

      overlay = (import ./pkgs);

      overlays =
        let
          overlayDir = ./overlays;
          fullPath = name: overlayDir + "/${name}";
          overlayPaths = map fullPath (attrNames (readDir overlayDir));
        in
        pathsToImportedAttrs overlayPaths;

      packages."${system}" =
        let
          packages = self.overlay osPkgs osPkgs ;
          overlays = lib.filterAttrs (n: v: n != "pkgs") self.overlays;

          overlayPkgs =
            genAttrs
              (attrNames overlays)
              (name: (overlays."${name}" osPkgs osPkgs)."${name}");
        in
        recursiveUpdate packages overlayPkgs;

      nixosModules =
        let
          # binary cache
          cachix = import ./cachix.nix;
          cachixAttrs = { inherit cachix; };

          # modules
          moduleList = import ./modules/list.nix;
          modulesAttrs = pathsToImportedAttrs moduleList;

          # profiles
          profilesList = import ./profiles/list.nix;
          profilesAttrs = { profiles = pathsToImportedAttrs profilesList; };

        in
        recursiveUpdate
          (recursiveUpdate cachixAttrs modulesAttrs)
          profilesAttrs;

      templates.flk.path = ./.;
      templates.flk.description = "https://github.com/GTrunSec/nixos-flk";
      defaultTemplate = self.templates.flk;
    };
}
