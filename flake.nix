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
      latest.url = "nixpkgs/nixos-unstable";
      digga = { url = "github:divnix/digga"; };
      naersk = { url = "github:nmattia/naersk"; inputs.nixpkgs.follows = "latest"; };
      flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
      bud.url = "github:divnix/bud";
      #bud.url = "/home/gtrun/src/bud";
      qnr.url = "github:divnix/quick-nix-registry";
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
      beautysh = { url = "github:lovesegfault/beautysh"; };
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
      photoprism2nix = { url = "github:GTrunSec/photoprism2nix"; };
      tenvideo = { url = "github:GTrunSec/Tenvideo-nix-flake"; };
      rust-overlay = { url = "github:oxalica/rust-overlay"; };
      emacs-ng = { url = "github:emacs-ng/emacs-ng"; };
      nixpkgs-hardenedliux = { url = "github:hardenedlinux/nixpkgs-hardenedlinux"; };
      gomod2nix = { url = "github:tweag/gomod2nix"; };
    };

  outputs = inputs: with builtins; with inputs; with inputs.darwin;
    digga.lib.mkFlake
      {
        inherit self inputs;
        supportedSystems = [ "x86_64-linux" ];
        channelsConfig = {
          allowUnfree = true;
          allowBroken = true;
          allowUnsupportedSystem = true;
        };

        channels = {
          nixos = {
            imports = [ (digga.lib.importOverlays ./overlays) ];
            overlays = [
              ./pkgs/default.nix
              (final: prev: {
                emacsNg = emacs-ng.defaultPackage.x86_64-linux;
                beautysh = beautysh.defaultPackage."${final.system}";
              })
              nur.overlay
              digga.overlays.patchedNix
              agenix.overlay
              nvfetcher.overlay
              tenvideo.overlay
              rust-overlay.overlay
              sops-nix.overlay
              nixpkgs-hardenedliux.overlay
            ];
          };
          latest = { };
        };

        lib = import ./lib { lib = digga.lib // nixos.lib; };

        sharedOverlays = [
          (final: prev:
            {
              machlib = import mach-nix {
                pkgs = prev;
                pypiData = pypi-deps-db;
              };
              lib = prev.lib.extend (lfinal: lprev: {
                our = self.lib;
              });
            })
          gomod2nix.overlay
        ];


        devshell = ./shell;

        nixos = {
          hostDefaults = {
            system = "x86_64-linux";
            channelName = "nixos";
            imports = [ (digga.lib.importModules ./modules) ];
            externalModules = [
              { _module.args.ourLib = self.lib; }
              digga.nixosModules.nixConfig
              ci-agent.nixosModules.agent-profile
              home.nixosModules.home-manager
              agenix.nixosModules.age
              bud.nixosModules.bud
              sops-nix.nixosModules.sops
              qnr.nixosModules.local-registry
              #User's custom modules
              photoprism2nix.nixosModules.photoprism
            ];
          };

          imports = [ (digga.lib.importHosts ./hosts) ];
          hosts = {
            /* set host specific properties here */
            NixOS = {
              tests = [
                {
                  name = "Test";
                  machine = { ... }: { };
                  testScript = ''
                    start_all()
                  '';
                }
              ];
            };
          };

          importables = rec {
            profiles = digga.lib.rakeLeaves ./profiles // {
              users = digga.lib.rakeLeaves ./users;
              virtualisation = digga.lib.rakeLeaves ./profiles/virtualisation;
              registry = digga.lib.rakeLeaves ./profiles/registry;
            };
            suites = with profiles; rec {
              base = [ core users.gtrun users.root ];
              graphics = base ++ [
                core-custom
                graphical
                code
                application
                data
                fonts
                devices
                network
                search
                ssh
                nsm
                virtualisation.docker
                virtualisation.libvirtd
                registry.nixos
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
            (digga.lib.importModules ./users/modules)
          ];
          externalModules = [ ];
          importables = rec {
            profiles = digga.lib.rakeLeaves ./users/profiles;
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
                gpg
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

        ########################
        # # Builder Packages   #
        ########################
        outputsBuilder = channels: {
          packages = {
            #nix develop .#sops-shell --impure
            sops-shell = with channels.nixos; mkShell {
              sopsPGPKeyDirs = [
                #"./secrets/keys/hosts"
                "./secrets/keys/users"
              ];
              nativeBuildInputs = [ sops-import-keys-hook ];
            };
          };
        };
      } // { };
}
