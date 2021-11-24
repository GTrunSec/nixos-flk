{
  description = "A highly structured configuration database => User:Guangtao";

  nixConfig.extra-substituters = [
    "https://nix-community.cachix.org"
  ];
  nixConfig.extra-trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  inputs =
    {
      ##################
      # Default Flakes #
      ##################
      nixos.url = "nixpkgs/release-21.11";
      latest.url = "github:NixOS/nixpkgs/master";
      devshell = { url = "github:numtide/devshell"; inputs.nixpkgs.follows = "nixos"; };
      flake-utils-plus = { url = "github:gytis-ivaskevicius/flake-utils-plus"; };
      digga = {
        url = "github:divnix/digga";
        inputs.nixpkgs.follows = "nixos";
        inputs.nixlib.follows = "nixos";
        inputs.devshell.follows = "devshell";
        inputs.flake-utils-plus.follows = "flake-utils-plus";
      };
      bud = {
        url = "github:divnix/bud";
        #bud.url = "/home/gtrun/ghq/github.com/GTrunSec/bud";
        inputs.nixpkgs.follows = "nixos";
        inputs.devshell.follows = "devshell";
      };
      vs-ext = {
        url = "github:gtrunsec/vs-ext/lib";
        #url = "/home/gtrun/ghq/github.com/divnix/vs-ext";
        inputs.nixpkgs.follows = "latest";
      };
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
        inputs.nixpkgs.follows = "latest";
      };
      nixos-hardware.url = "github:nixos/nixos-hardware";
      nur.url = "github:nix-community/NUR";
      sops-nix.url = "github:Mic92/sops-nix";
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
      } // {
      budModules = {
        bud = import ./shell/bud;
      };
    };
}
