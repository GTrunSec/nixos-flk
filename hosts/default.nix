{ home
, photoprism-flake
, lib
, nixos
, master
, pkgset
, self
, system
, utils
, ...
}:
let
  inherit (utils) recImport;
  inherit (builtins) attrValues removeAttrs;
  inherit (pkgset) osPkgs pkgs stable;

  config = hostName:
    lib.nixosSystem {
      inherit system;

      modules =
        let
          inherit (home.nixosModules) home-manager;
          inherit (photoprism-flake.nixosModules) photoprism;
          core = self.nixosModules.profiles.core;

          global = {
            networking.hostName = hostName;
            nix.nixPath = let path = toString ../.; in
              [
                "nixpkgs=${master}"
                "nixos=${nixos}"
                "nixos-config=${path}/configuration.nix"
                "nixpkgs-overlays=${path}/overlays"
              ];

            nixpkgs = { pkgs = osPkgs; };

            nix.registry = {
              nixos.flake = nixos;
              nixflk.flake = self;
              nixpkgs.flake = master;
            };
          };

          overrides = {
            # use latest systemd
            systemd.package = pkgs.systemd;

            nixpkgs.overlays =
              let
                override = import ../pkgs/override.nix pkgs stable;

                overlay = pkg: final: prev: {
                  "${pkg.pname}" = pkg;
                };
              in
              map overlay override;
          };

          local = import "${toString ./.}/${hostName}.nix";

          # Everything in `./modules/list.nix`.
          flakeModules =
            attrValues (removeAttrs self.nixosModules [ "profiles" ]);

        in
        flakeModules ++ [ core global local home-manager overrides photoprism ];

    };

  hosts = recImport {
    dir = ./.;
    _import = config;
  };
in
hosts
