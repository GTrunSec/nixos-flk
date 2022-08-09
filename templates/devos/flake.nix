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
    nixos_21_11.url = "github:NixOS/nixpkgs/nixos-21.11";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixos";

    home.url = "github:nix-community/home-manager";
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
    darwin-emacs.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
  };

  inputs = {
    digga.url = "github:divnix/digga/?ref=refs/pull/472/head";
    digga.inputs.nixpkgs.follows = "nixos";
    digga.inputs.devshell.follows = "devshell";
    digga.inputs.home-manager.follows = "home";

    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
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

    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  #################
  # Custom Flakes #
  #################
  inputs = {};

  outputs = {
    self,
    digga,
    ...
  } @ inputs:
    digga.lib.mkFlake
    {
      inherit self inputs;

      channelsConfig = {allowUnfree = true;};

      channels = import ./channels inputs;

      lib = import ./lib {lib = digga.lib // inputs.nixos.lib;};

      sharedOverlays = import ./overlays/shared inputs;

      devshell = ./devshell;

      # nixos = ./nixos;
      nixos = {hostDefaults.channelName = "nixos";};

      darwin = ./darwin;

      home = ./home;

      homeConfigurations =
        digga.lib.mergeAny
        (digga.lib.mkHomeConfigurations self.darwinConfigurations)
        (digga.lib.mkHomeConfigurations self.nixosConfigurations);

      ########################
      # # Builder Packages   #
      ########################
      # outputsBuilder = channels: import ./pkgs/output-builder channels inputs;
    };
}
