{
  description = "A highly structured configuration database => User:Guangtao";
  nixConfig.extra-experimental-features = "nix-command flakes ca-references";
  nixConfig.extra-substituters = "https://nrdxp.cachix.org https://nix-community.cachix.org";
  nixConfig.extra-trusted-public-keys = "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";

  inputs =
    {
      ##################
      # Default Flakes #
      ##################
      nixos.url = "nixpkgs/release-21.05";
      latest.url = "nixpkgs";
      digga = {
        url = "github:divnix/digga/develop";
        inputs.nipxkgs.follows = "latest";
      };
      naersk = {
        url = "github:nmattia/naersk";
        inputs.nixpkgs.follows = "latest";
      };
      flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
      bud.url = "github:gtrunsec/bud/nixos-rebuild";
      #bud.url = "/home/gtrun/src/bud";
      quick-nix-registry.url = "github:divnix/quick-nix-registry";

      ####################
      # Default Features #
      ####################
      nix-dram = {
        url = "github:dramforever/nix-dram";
        inputs.nixpkgs.follows = "nixos";
      };
      ci-agent = {
        url = "github:hercules-ci/hercules-ci-agent";
        inputs = { nix-darwin.follows = "darwin"; nixos-20_09.follows = "nixos"; nixos-unstable.follows = "latest"; };
      };
      darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "latest";
      };
      home = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixos";
      };
      nixos-hardware.url = "github:nixos/nixos-hardware";
      nur.url = "github:nix-community/NUR";
      sops-nix.url = "github:Mic92/sops-nix";
      agenix.url = "github:ryantm/agenix";
      nvfetcher = {
        url = "github:berberman/nvfetcher";
        inputs.nixpkgs.follows = "latest";
      };
      ######################
      # Python Environment #
      ######################
      mach-nix = { url = "github:DavHau/mach-nix"; inputs.nixpkgs.follows = "nixos"; inputs.pypi-deps-db.follows = "pypi-deps-db"; };
      pypi-deps-db = {
        url = "github:DavHau/pypi-deps-db";
        flake = false;
      };

      #################
      # Custom Flakes #
      #################
      stable.url = "nixpkgs/684d5d27136f154775c95005dcce2d32943c7c9e";
      emacs-overlay = { url = "github:nix-community/emacs-overlay"; };
      nixpkgs-hardenedlinx = { url = "github:hardenedlinux/nixpkgs-hardenedlinux"; };
      photoprism = { url = "github:GTrunSec/photoprism-flake"; inputs.nixpkgs.follows = "stable"; };
      brim-flake = { url = "github:hardenedlinux/brim-flake"; inputs.nixpkgs.follows = "nixos"; };
      vast2nix = { url = "github:GTrunSec/vast2nix"; };
      #vast2nix = { url = "/home/gtrun/src/vast2nix"; };
      threatbus2nix = { url = "github:GTrunSec/threatbus2nix"; };
      spicy2nix = { url = "github:GTrunSec/spicy2nix"; };
      zeek2nix = { url = "github:hardenedlinux/zeek2nix"; };
      tenvideo = { url = "github:GTrunSec/Tenvideo-nix-flake"; inputs.nixpkgs.follows = "nixos"; };
      rust-overlay = { url = "github:oxalica/rust-overlay"; inputs.nixpkgs.follows = "nixos"; };
      emacsNg = { url = "github:emacs-ng/emacs-ng"; inputs.rust-overlay.follows = "rust-overlay"; inputs.nixpkgs.follows = "nixos"; };
    };

  outputs = inputs: with builtins; with inputs; with inputs.darwin;
    let
      bud' = bud self; # rebind to access self.budModules
    in
    digga.lib.mkFlake
      {
        inherit self inputs;

        channelsConfig = {
          allowUnfree = true;
          allowBroken = true;
          allowUnsupportedSystem = true;
        };

        channels = {
          nixos = {
            imports = [ (digga.lib.importers.overlays ./overlays) ];
            overlays = [
              ./pkgs/default.nix
              nur.overlay
              digga.overlays.patchedNix
              agenix.overlay
              nvfetcher.overlay
              tenvideo.overlay
              spicy2nix.overlay
              zeek2nix.overlay
              emacs-overlay.overlay
              emacsNg.overlay
              rust-overlay.overlay
              brim-flake.overlay
              sops-nix.overlay
            ];
          };
          latest = { };
        };

        lib = import ./lib { lib = digga.lib // nixos.lib; };

        sharedOverlays = [
          (final: prev:
            {
              sources = (import ./pkgs/_sources/generated.nix) { inherit (final) fetchurl fetchgit; };
              machlib = import mach-nix {
                pkgs = prev;
                pypiDataRev = pypi-deps-db.rev;
                pypiDataSha256 = pypi-deps-db.narHash;
              };
              lib = prev.lib.extend (lfinal: lprev: {
                our = self.lib;
              });
            })
          nvfetcher.overlay
        ];


        devshell = {
          modules = [ ./devshell.toml (import ./shell bud') ];
          externalModules = { pkgs, ... }: { };
        };


        nixos = {
          hostDefaults = {
            system = "x86_64-linux";
            channelName = "nixos";
            imports = [ (digga.lib.importers.modules ./modules) ];
            externalModules = [
              { _module.args.ourLib = self.lib; }
              ci-agent.nixosModules.agent-profile
              home.nixosModules.home-manager
              agenix.nixosModules.age
              (bud.nixosModules.bud bud')
              sops-nix.nixosModules.sops
              quick-nix-registry.nixosModules.local-registry
              #User's custom modules
              photoprism.nixosModules.photoprism
              vast2nix.nixosModules.vast
              zeek2nix.nixosModules.zeek
              threatbus2nix.nixosModules.threatbus
              threatbus2nix.nixosModules.threatbus-vast
            ];
          };

          imports = [ (digga.lib.importers.hosts ./hosts) ];
          hosts = {
            /* set host specific properties here */
            NixOS = { };
          };

          importables = rec {
            profiles = digga.lib.importers.rakeLeaves ./profiles // {
              users = digga.lib.importers.rakeLeaves ./users;
            };
            suites = with profiles; rec {
              base = [ core users.gtrun users.root ];
              graphics = base ++ [
                core-extend
                graphical
                code
                application
                data
                virt
                fonts
                devices
                network
                search
                ssh
                nsm
              ];
            };
          };
        };

        hosts."MacBook" = {
          # This host will be exported under the flake's `darwinConfigurations` output
          output = "darwinConfigurations";

          # Build host with darwinSystem
          builder = darwin.lib.darwinSystem;

          # This host uses `channels.unstable.{input,overlaysBuilder,config,patches}` attributes instead of `channels.nixpkgs.<...>`
          channelName = "nixpkgs";

          # Host specific configuration. Same as `sharedModules`
          modules = [
            (import ./hosts/MacBook)
            ci-agent.darwinModules.agent-profile
            home.darwinModules.home-manager
          ];
        };

        home = {
          imports = [
            (digga.lib.importers.modules ./users/modules)
          ];
          externalModules = [ ];
          importables = rec {
            profiles = digga.lib.importers.rakeLeaves ./users/profiles;
            suites = with profiles; rec {
              base = [
                home-services
                direnv
                git
                feh
                zsh
                doom-emacs
                cursor
                alacritty
                tmux
                link-home-file
                home-packages
                randr
              ] ++ services;
              services = [ lorri ];
            };
          };
        };

        homeConfigurations = digga.lib.mkHomeConfigurations self.nixosConfigurations;

        deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

        defaultTemplate = self.templates.flk;
        templates.flk.path = ./.;
        templates.flk.description = "flk template";


        outputsBuilder = channels: {
          packages = {
            sops-shell = channels.nixos.mkShell {
              sopsPGPKeyDirs = [
                #"./secrets/keys/hosts"
                "./secrets/keys/users"
              ];
              nativeBuildInputs = with channels.nixos; [ sops-pgp-hook ];
            };
          };
        };
      } // {
      budModules = { devos = import ./pkgs/bud; };
    };
}
