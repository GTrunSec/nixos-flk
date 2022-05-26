{
  description = "A highly structured configuration database => User:Guangtao";

  nixConfig.extra-substituters = [
    "https://nix-community.cachix.org"
  ];
  nixConfig.extra-trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  inputs = {
    ##################
    # Default Flakes #
    ##################
    nixos.url = "github:NixOS/nixpkgs/release-22.05";
    nixos-latest.url = "github:NixOS/nixpkgs/master";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos_21_05.url = "github:NixOS/nixpkgs/nixos-21.05";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixos";

    # nix.url = "github:NixOS/nix";}

    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "nixos-latest";

    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  ###################
  # Darwin Channels #
  ###################
  inputs = {
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "darwin-nixpkgs";
    darwin-nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-21.11-darwin";
    darwin-emacs.url = "github:NixOS/nixpkgs/nixpkgs-21.11-darwin";
  };

  inputs = {
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    digga.url = "github:divnix/digga";
    digga.inputs.nixpkgs.follows = "nixos";
    digga.inputs.devshell.follows = "devshell";
    digga.inputs.flake-utils-plus.follows = "flake-utils-plus";

    devos-ext-lib.url = "github:divnix/devos-ext-lib/d8f43e823955c7005c09427d2bbc9ef6a9a59051";
    devos-ext-lib.inputs.nixpkgs.follows = "nixos-latest";

    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
    qnr.url = "github:divnix/quick-nix-registry";
  };

  ####################
  # Default Features #
  ####################
  inputs = {
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixos";

    gomod2nix.url = "github:tweag/gomod2nix";

    emacs-overlay.url = "github:nix-community/emacs-overlay/27fea646189ff7572453e1e3a4d1eb9dc5887fb2";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixos";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";

    alejandra.url = "github:kamadorueda/alejandra";
    alejandra.inputs.nixpkgs.follows = "nixos";
  };

  #################
  # Custom Flakes #
  #################
  inputs = {
    photoprism2nix.url = "github:GTrunSec/photoprism2nix";
    photoprism2nix.inputs.nixpkgs.follows = "nixos";

    tenvideo.url = "github:GTrunSec/Tenvideo-nix-flake";
    tenvideo.inputs.nixpkgs.follows = "nixos";
  };

  outputs = {
    self,
    digga,
    ...
  } @ inputs:
    digga.lib.mkFlake
    {
      inherit self inputs;

      supportedSystems = ["x86_64-linux"];

      channelsConfig = {
        allowUnfree = true;
        allowBroken = true;
        allowUnsupportedSystem = true;
      };

      channels = import ./channels {inherit self inputs;};

      lib = import ./lib {lib = digga.lib // inputs.nixos.lib;};

      sharedOverlays = import ./channels/overlays/common {inherit self inputs;};

      devshell = ./devshell;

      nixos = ./nixos;

      darwin = ./darwin;

      home = ./users;

      homeConfigurations = digga.lib.mkHomeConfigurations self.nixosConfigurations;

      ########################
      # # Builder Packages   #
      ########################
      outputsBuilder = channels: import ./pkgs/output-builder channels inputs;
    };
}
