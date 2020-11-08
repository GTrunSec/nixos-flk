{
  description = "User:GTrunSec - A highly structured configuration database.";

  inputs =
    {
      master.url = "nixpkgs/8bdebd463bc77c9b83d66e690cba822a51c34b9b";
      unstable.url = "nixpkgs/684d5d27136f154775c95005dcce2d32943c7c9e";
      nixos.url = "nixpkgs/8bdebd463bc77c9b83d66e690cba822a51c34b9b";
      home.url = "github:rycee/home-manager/bqv-flakes";
      nixpkgs-hardenedlinux = { url = "github:hardenedlinux/nixpkgs-hardenedlinux"; flake = false;};
      photoprism-flake.url = "github:GTrunSec/photoprism-flake";
      nuclear-flake.url = "github:GTrunSec/nuclear-music-flake";
      zeek-nix = { url = "github:hardenedlinux/zeek-nix/main"; flake = false;};
    };

  outputs = inputs@{ self, home, nixos, master, unstable, nixpkgs-hardenedlinux, photoprism-flake, nuclear-flake, zeek-nix}:
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
                          nuclear-flake.overlay
                        ];
          config = { allowUnfree = true; };
        };

      pkgset = {
        osPkgs = pkgImport nixos;
        pkgs = pkgImport master;
        unstable = pkgImport unstable;
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
