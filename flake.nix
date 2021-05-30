{
  description = "A highly structured configuration database.";

  inputs =
    {
      nixos.url = "github:GTrunSec/nixpkgs/2c843b6903cacff74fe8daa0bbe59e350716dedc";
      #nixos.url = "nixpkgs/ccabc238a8bd142e58c2cd8db8ebd78ab38555d9";
      latest.url = "nixpkgs";
      digga.url = "github:divnix/digga";

      ci-agent = {
        url = "github:hercules-ci/hercules-ci-agent";
        inputs = { nix-darwin.follows = "darwin"; nixos-20_09.follows = "nixos"; nixos-unstable.follows = "latest"; };
      };
      devshell.url = "github:numtide/devshell";
      darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "latest";
      };
      home.url = "github:nix-community/home-manager";
      home.inputs.nixpkgs.follows = "nixos";
      naersk.url = "github:nmattia/naersk";
      naersk.inputs.nixpkgs.follows = "latest";
      nixos-hardware.url = "github:nixos/nixos-hardware";
      flake-compat.url = "github:BBBSnowball/flake-compat/pr-1";
      flake-compat.flake = false;


      pkgs.url = "path:./pkgs";
      pkgs.inputs.nixpkgs.follows = "nixos";
      nur.url = github:nix-community/NUR;


      stable.url = "nixpkgs/684d5d27136f154775c95005dcce2d32943c7c9e";
      emacs-overlay = { url = "github:nix-community/emacs-overlay"; };
      photoprism-flake = { url = "github:GTrunSec/photoprism-flake"; inputs.nixpkgs.follows = "stable"; };
      nixpkgs-hardenedlinux = { url = "github:hardenedlinux/nixpkgs-hardenedlinux"; flake = false; };
      brim-flake = { url = "github:hardenedlinux/brim-flake"; inputs.nixpkgs.follows = "nixos"; };
      vast-flake = { url = "github:GTrunSec/vast/nix-flake"; inputs.nixpkgs-hardenedlinux.follows = "nixpkgs-hardenedlinux"; };
      threatbus-flake = { url = "github:GTrunSec/threatbus-nix-flake/main"; inputs.nixpkgs-hardenedlinux.follows = "nixpkgs-hardenedlinux"; inputs.vast-flake.follows = "vast-flake"; };
      #threatbus-flake = { url = "/home/gtrun/src/threatbus-nix-flake";  inputs.nixpkgs-hardenedlinux.follows = "nixpkgs-hardenedlinux"; };
      zeek-nix = { url = "github:hardenedlinux/zeek-nix/main"; };
      tenvideo = { url = "github:GTrunSec/Tenvideo-nix-flake"; inputs.nixpkgs.follows = "nixos"; };
      rust-overlay = { url = "github:oxalica/rust-overlay"; inputs.nixpkgs.follows = "nixos"; };
      emacsNg-flake = { url = "github:emacs-ng/emacs-ng"; inputs.rust-overlay.follows = "rust-overlay"; inputs.nixpkgs.follows = "nixos"; };
    };

  outputs = inputs: with builtins; with inputs;
    digga.lib.mkFlake {
      inherit self inputs;

      channelsConfig = { allowUnfree = true; };

      channels = {
        nixos = {
          imports = [ (digga.lib.importers.overlays ./overlays) ];
          overlays = [
            ./pkgs/default.nix
            pkgs.overlay # for `srcs`
            nur.overlay
          ];
        };
        latest = { };
      };

      lib = import ./lib { lib = digga.lib // nixos.lib; };

      sharedOverlays = [
        (final: prev: {
          lib = prev.lib.extend (lfinal: lprev: {
            our = self.lib;
          });
        })
        tenvideo.overlay
        zeek-nix.overlay
        emacs-overlay.overlay
        emacsNg-flake.overlay
        rust-overlay.overlay
        brim-flake.overlay
      ];

      nixos = {
        hostDefaults = {
          system = "x86_64-linux";
          channelName = "nixos";
          modules = ./modules/module-list.nix;
          externalModules = [
            { _module.args.ourLib = self.lib; }
            ci-agent.nixosModules.agent-profile
            home.nixosModules.home-manager
            ./modules/customBuilds.nix

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
        profiles = [ ./profiles ./users ];
        suites = { profiles, users, ... }: with profiles; rec {
          base = [ core users.nixos users.root ];
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

      home = {
        modules = ./users/modules/module-list.nix;
        externalModules = [ ];
        profiles = [ ./users/profiles ];
        suites = { profiles, ... }: with profiles; rec {
          base = [
            default-home
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

      homeConfigurations = digga.lib.mkHomeConfigurations self.nixosConfigurations;

      deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

      defaultTemplate = self.templates.flk;
      templates.flk.path = ./.;
      templates.flk.description = "flk template";
    }
  ;
}
