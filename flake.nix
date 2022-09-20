{
  description = "A highly structured configuration database => User:Guangtao";

  nixConfig.extra-substituters = [
    "https://nix-community.cachix.org"
    "https://emacs.cachix.org"
  ];
  nixConfig.extra-trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "emacs.cachix.org-1:b1SMJNLY/mZF6GxQE+eDBeps7WnkT0Po55TAyzwOxTY="
  ];

  inputs = {
    ##################
    # Default Flakes #
    ##################
    nixpkgs.follows = "nixos";
    nixos.url = "github:NixOS/nixpkgs/release-22.05";
    nixos-latest.url = "github:NixOS/nixpkgs/master";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixos";

    home.url = "github:nix-community/home-manager/f26946858e07384860bf288f20e39a8d32ed5b71";
    home.inputs.nixpkgs.follows = "nixos-latest";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-generators.url = "github:nix-community/nixos-generators";
  };

  ###################
  # Darwin Channels #
  ###################
  inputs = {
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "darwin-nixpkgs";
    darwin-nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";

    darwin-emacs.url = "github:cmacrae/emacs";
  };

  inputs = {
    digga.url = "github:divnix/digga/?ref=refs/pull/472/head";
    digga.inputs.nixpkgs.follows = "nixos";
    digga.inputs.devshell.follows = "devshell";
    digga.inputs.home-manager.follows = "home";

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

    ragenix.url = "github:yaxitech/ragenix";
    ragenix.inputs.nixpkgs.follows = "nixos";

    gomod2nix.url = "github:tweag/gomod2nix";

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixos";

    nil.url = "github:oxalica/nil";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";

    alejandra.url = "github:kamadorueda/alejandra";
    alejandra.inputs.nixpkgs.follows = "nixos";
  };

  #################
  # Custom Flakes #
  #################
  inputs = {
    photoprism2nix.url = "github:GTrunSec/photoprism2nix";
    photoprism2nix.inputs.nixpkgs.follows = "nixos-unstable";

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

      supportedSystems = ["x86_64-linux" "x86_64-darwin"];

      channelsConfig = {
        allowUnfree = true;
        allowUnsupportedSystem = true;
      };

      channels = import ./channels {inherit self inputs;};

      lib = import ./lib {lib = digga.lib // inputs.nixos.lib;};

      sharedOverlays = import ./overlays/shared inputs;

      devshell = ./devshell;

      nixos = ./nixos;

      darwin = ./darwin;

      home = ./home;

      homeConfigurations =
        digga.lib.mergeAny
        (digga.lib.mkHomeConfigurations self.darwinConfigurations)
        (digga.lib.mkHomeConfigurations self.nixosConfigurations);

      ########################
      # # Builder Packages   #
      ########################
      outputsBuilder = channels: import ./pkgs/output-builder channels inputs;
      templates = {
        devos = {
          description = "devos default template";
          path = ./templates/devos;
        };
      };
    };
}
