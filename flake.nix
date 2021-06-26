{
  description = "A highly structured configuration database.";

  inputs =
    {
      nixos.url = "nixpkgs/release-21.05";
      latest.url = "nixpkgs";
      digga.url = "github:divnix/digga/develop";
      quick-nix-registry.url = "github:divnix/quick-nix-registry";
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
      home.url = "github:nix-community/home-manager";
      home.inputs.nixpkgs.follows = "nixos";
      nixos-hardware.url = "github:nixos/nixos-hardware";
      flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };

      nur.url = github:nix-community/NUR;

      sops-nix.url = github:Mic92/sops-nix;


      ######################
      # Python Environment #
      ######################
      mach-nix = { url = "github:DavHau/mach-nix"; inputs.nixpkgs.follows = "nixos"; inputs.pypi-deps-db.follows = "pypi-deps-db"; };
      pypi-deps-db = {
        url = "github:DavHau/pypi-deps-db";
        flake = false;
      };


      nvfetcher = {
        url = "github:berberman/nvfetcher";
        inputs.nixpkgs.follows = "nixos";
      };
      stable.url = "nixpkgs/684d5d27136f154775c95005dcce2d32943c7c9e";
      emacs-overlay = { url = "github:nix-community/emacs-overlay"; };
      nixpkgs-hardenedlinx = { url = "github:hardenedlinux/nixpkgs-hardenedlinux"; inputs.nixpkgs.follows = "nixos"; inputs.digga.follows = "digga"; inputs.nvfetcher-flake.follows = "nvfetcher"; };
      photoprism-flake = { url = "github:GTrunSec/photoprism-flake"; inputs.nixpkgs.follows = "stable"; };
      brim-flake = { url = "github:hardenedlinux/brim-flake"; inputs.nixpkgs.follows = "nixos"; };
      vast-flake = { url = "github:GTrunSec/vast/nix-flake"; };
      threatbus-flake = { url = "github:GTrunSec/threatbus-nix-flake/main"; inputs.vast-flake.follows = "vast-flake"; };
      #threatbus-flake = { url = "/home/gtrun/src/threatbus-nix-flake";  inputs.nixpkgs-hardenedlinux.follows = "nixpkgs-hardenedlinux"; };
      zeek-nix = { url = "github:hardenedlinux/zeek-nix"; inputs.nixpkgs.follows = "nixos"; inputs.nvfetcher-flake.follows = "nvfetcher"; };
      tenvideo = { url = "github:GTrunSec/Tenvideo-nix-flake"; inputs.nixpkgs.follows = "nixos"; };
      rust-overlay = { url = "github:oxalica/rust-overlay"; inputs.nixpkgs.follows = "nixos"; };
      emacsNg = { url = "github:emacs-ng/emacs-ng"; inputs.rust-overlay.follows = "rust-overlay"; inputs.nixpkgs.follows = "nixos"; };
    };

  outputs = inputs: with builtins; with inputs; with inputs.darwin; let
    machLib = mach-nix.lib."x86_64-linux";
  in
  digga.lib.mkFlake {
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
          nvfetcher.overlay
          tenvideo.overlay
          zeek-nix.overlay
          emacs-overlay.overlay
          emacsNg.overlay
          rust-overlay.overlay
          brim-flake.overlay
          sops-nix.overlay
          nix-dram.overlay
        ];
      };
      latest = { };
    };

    lib = import ./lib { lib = digga.lib // nixos.lib; };

    sharedOverlays = [
      (final: prev:
        {
          inherit machLib;
          sources = (import ./pkgs/_sources/generated.nix) { inherit (final) fetchurl fetchgit; };
          lib = prev.lib.extend (lfinal: lprev: {
            our = self.lib;
          });
        })
      nvfetcher.overlay
    ];


    devshell = {
      modules = [ ./devshell.toml ];
      externalModules = { pkgs, ... }: {
        packages = with pkgs;
          [
            sops
            sops-init-gpg-key
          ];
        commands = [
          {
            name = pkgs.nvfetcher-bin.pname;
            help = pkgs.nvfetcher-bin.meta.description;
            command = "cd $DEVSHELL_ROOT/pkgs; ${pkgs.nvfetcher-bin}/bin/nvfetcher -c ./sources.toml --no-output $@";
          }
        ];
      };
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
          ./modules/customBuilds.nix
          sops-nix.nixosModules.sops
          quick-nix-registry.nixosModules.local-registry
          #User's custom modules
          photoprism-flake.nixosModules.photoprism
          vast-flake.nixosModules.vast
          zeek-nix.nixosModules.zeek
          threatbus-flake.nixosModules.threatbus
          threatbus-flake.nixosModules.threatbus-vast
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
        home-manager.darwinModules.home-manager
      ];
    };

    home = {
      imports = [ (digga.lib.importers.modules ./users/modules) ];
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
    homeConfigurations = digga.lib.mkHomeConfigurations
      self.nixosConfigurations;

    deploy.nodes = digga.lib.mkDeployNodes
      self.nixosConfigurations
      { };

    defaultTemplate = self.templates.flk;
    templates.flk.path = ./.;
    templates.flk.description = "flk template";
  };
}
