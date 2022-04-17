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
    nixos.url = "github:NixOS/nixpkgs/nixos-21.11";
    latest.url = "github:NixOS/nixpkgs/master";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos_21_05.url = "github:NixOS/nixpkgs/nixos-21.05";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixos";

    # nix.url = "github:NixOS/nix";}
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    digga.url = "github:divnix/digga";
    digga.inputs.nixpkgs.follows = "nixos";
    digga.inputs.deploy.follows = "deploy";
    digga.inputs.devshell.follows = "devshell";
    digga.inputs.flake-utils-plus.follows = "flake-utils-plus";

    deploy.url = "github:serokell/deploy-rs";

    devos-ext-lib.url = "github:divnix/devos-ext-lib/d8f43e823955c7005c09427d2bbc9ef6a9a59051";
    devos-ext-lib.inputs.nixpkgs.follows = "latest";

    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
    qnr.url = "github:divnix/quick-nix-registry";
    ####################
    # Default Features #
    ####################

    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "latest";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";

    gomod2nix.url = "github:tweag/gomod2nix";

    nix-filter.url = "github:numtide/nix-filter";
    nix-filter.inputs.nixpkgs.follows = "nixos";
    #################
    # Custom Flakes #
    #################
    photoprism2nix.url = "github:GTrunSec/photoprism2nix";
    photoprism2nix.inputs.nixpkgs.follows = "nixos";
    tenvideo.url = "github:GTrunSec/Tenvideo-nix-flake";
    tenvideo.inputs.nixpkgs.follows = "nixos";
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    rust-overlay.url = "github:oxalica/rust-overlay";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";
    alejandra.url = "github:kamadorueda/alejandra";
    cells-lab.url = "github:gtrunsec/DevSecOps-cells-lab";
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

      lib = import ./lib {lib = digga.lib // inputs.nixpkgs.lib;};

      sharedOverlays = import ./channels/overlays/common {inherit self inputs;};

      devshell = ./devshell;

      nixos = ./nixos;

      home = ./users;

      homeConfigurations = digga.lib.mkHomeConfigurations self.nixosConfigurations;

      deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations {
        NixOS = {
          hostname = "10.220.170.112";
          sshUser = "root";
          fastConnect = true;
        };
      };
      ########################
      # # Builder Packages   #
      ########################
      outputsBuilder = channels: import ./pkgs/output-builder channels inputs;
    };
}
