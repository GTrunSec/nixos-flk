{
  description = "A highly structured configuration database => User:Guangtao";

  nixConfig.extra-experimental-features = "nix-command flakes ca-references";
  nixConfig.extra-substituters = [
    "https://nrdxp.cachix.org
    https://nix-community.cachix.org"
  ];
  nixConfig.extra-trusted-public-keys = [
    "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  inputs =
    {
      ##################
      # Default Flakes #
      ##################
      nixos.url = "nixpkgs/release-21.05";
      latest.url = "nixpkgs/nixos-unstable";
      nix.url = "github:nixos/nix";
      digga = {
        url = "github:divnix/digga";
        inputs.nixpkgs.follows = "nixos";
        inputs.nix.follows = "nix";
      };
      bud = {
        url = "github:divnix/bud";
        inputs.nixpkgs.follows = "nixos";
        inputs.devshell.follows = "digga/devshell";
      };
      #bud.url = "/home/gtrun/ghq/github.com/GTrunSec/bud";
      flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
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
        inputs = { nixos-20_09.follows = "nixos"; nixos-unstable.follows = "nixos"; };
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
        inputs.nixpkgs.follows = "nixos";
      };
      #beautysh = { url = "github:lovesegfault/beautysh"; inputs.nixpkgs.follows = "nixos"; };
      beautysh = { url = "github:gtrunsec/beautysh/flattenTree"; inputs.nixpkgs.follows = "nixos"; };
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
      photoprism2nix = { url = "github:GTrunSec/photoprism2nix"; inputs.nixpkgs.follows = "nixos"; };
      tenvideo = { url = "github:GTrunSec/Tenvideo-nix-flake"; inputs.nixpkgs.follows = "nixos"; };
      rust-overlay = { url = "github:oxalica/rust-overlay"; };
      emacs-ng = { url = "github:emacs-ng/emacs-ng"; };
      nixpkgs-hardenedlinux = { url = "github:hardenedlinux/nixpkgs-hardenedlinux"; };
      gomod2nix.follows = "nixpkgs-hardenedlinux/gomod2nix";
    };

  outputs = inputs: with builtins; with inputs;
    digga.lib.mkFlake
      {
        inherit self inputs;

        supportedSystems = [ "x86_64-linux" ];

        channelsConfig = {
          allowUnfree = true;
          allowBroken = true;
          allowUnsupportedSystem = true;
        };

        channels = import ./channels { inherit self inputs; };

        lib = import ./lib { lib = digga.lib // nixos.lib; };

        sharedOverlays = import ./overlays/share { inherit self inputs; };

        devshell = ./shell;

        nixos = ./nixos;

        home = ./nixos/home;

        #WIP macos support
        hosts = import ./nixos/hosts { inherit self inputs; };

        homeConfigurations = digga.lib.mkHomeConfigurations self.nixosConfigurations;

        deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

        defaultTemplate = self.templates.flk;
        templates.flk.path = ./.;
        templates.flk.description = "flk template";

        ########################
        # # Builder Packages   #
        ########################
        outputsBuilder = channels: import ./pkgs/output-builder channels inputs;
      } // { };
}
