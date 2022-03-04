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
    nixpkgs.url = "nixpkgs/release-21.11";
    latest.url = "github:NixOS/nixpkgs/master";
    nixpkgs_21_05.url = "nixpkgs/release-21.05";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils-plus = {url = "github:divnix/flake-utils-plus";};
    nix = {url = "github:NixOS/nix";};
    digga = {
      url = "github:divnix/digga";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.deploy.follows = "deploy";
      inputs.devshell.follows = "devshell";
      inputs.flake-utils-plus.follows = "flake-utils-plus";
    };
    deploy = {url = "github:serokell/deploy-rs";};
    devos-ext-lib = {
      url = "github:divnix/devos-ext-lib/d8f43e823955c7005c09427d2bbc9ef6a9a59051";
      inputs.nixpkgs.follows = "latest";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    qnr.url = "github:divnix/quick-nix-registry";
    ####################
    # Default Features #
    ####################
    # nix-dram = {
    #   url = "github:dramforever/nix-dram";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "latest";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    beautysh = {url = "github:lovesegfault/beautysh";};
    #################
    # Custom Flakes #
    #################
    photoprism2nix = {
      url = "github:GTrunSec/photoprism2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tenvideo = {
      url = "github:GTrunSec/Tenvideo-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {url = "github:oxalica/rust-overlay";};
    emacs-ng = {url = "github:emacs-ng/emacs-ng";};
    nixpkgs-hardenedlinux = {url = "github:hardenedlinux/nixpkgs-hardenedlinux";};
    alejandra = {url = "github:kamadorueda/alejandra";};
  };

  outputs = inputs:
    with inputs;
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

        lib = import ./lib {lib = digga.lib // nixos.lib;};

        sharedOverlays = import ./overlays/share {inherit self inputs;};

        devshell = ./shell;

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

        defaultTemplate = self.templates.flk;
        templates.flk.path = ./.;
        templates.flk.description = "flk template";

        ########################
        # # Builder Packages   #
        ########################
        outputsBuilder = channels: import ./pkgs/output-builder channels inputs;
      };
}
