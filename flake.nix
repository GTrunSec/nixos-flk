{
  description = "A highly structured configuration database.";

  inputs =
    {
      nixos = { url = "nixpkgs/ccabc238a8bd142e58c2cd8db8ebd78ab38555d9"; };

      override.url = "nixpkgs";
      ci-agent = {
        url = "github:hercules-ci/hercules-ci-agent";
        inputs = { nix-darwin.follows = "darwin"; flake-compat.follows = "flake-compat"; nixos-20_09.follows = "nixos"; nixos-unstable.follows = "override"; };
      };
      darwin.url = "github:LnL7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "override";
      deploy = {
        url = "github:serokell/deploy-rs";
        inputs = { flake-compat.follows = "flake-compat"; naersk.follows = "naersk"; nixpkgs.follows = "override"; utils.follows = "utils"; };
      };
      devshell.url = "github:numtide/devshell";
      flake-compat.url = "github:BBBSnowball/flake-compat/pr-1";
      flake-compat.flake = false;
      home.url = "github:nix-community/home-manager";
      home.inputs.nixpkgs.follows = "nixos";
      naersk.url = "github:nmattia/naersk";
      naersk.inputs.nixpkgs.follows = "override";
      nixos-hardware.url = "github:nixos/nixos-hardware";
      utils.url = "github:numtide/flake-utils";
      pkgs.url = "path:./pkgs";
      pkgs.inputs.nixpkgs.follows = "nixos";


      #User's custom flakes
      stable.url = "nixpkgs/684d5d27136f154775c95005dcce2d32943c7c9e";
      emacs-overlay = { url = "github:nix-community/emacs-overlay"; };
      photoprism-flake = { url = "github:GTrunSec/photoprism-flake"; inputs.nixpkgs.follows = "stable"; inputs.flake-utils.follows = "utils"; };
      nixpkgs-hardenedlinux = { url = "github:hardenedlinux/nixpkgs-hardenedlinux"; flake = false; };
      brim-flake = { url = "github:hardenedlinux/brim-flake"; inputs.nixpkgs.follows = "nixos"; };
      vast-flake = { url = "github:GTrunSec/vast/nix-flake"; };
      threatbus-flake = { url = "github:GTrunSec/threatbus-nix-flake/main"; inputs.flake-utils.follows = "utils"; inputs.nixpkgs-hardenedlinux.follows = "nixpkgs-hardenedlinux"; inputs.vast-flake.follows = "vast-flake"; };
      #threatbus-flake = { url = "/home/gtrun/src/threatbus-nix-flake"; inputs.flake-utils.follows = "utils"; inputs.nixpkgs-hardenedlinux.follows = "nixpkgs-hardenedlinux"; };
      zeek-nix = { url = "github:hardenedlinux/zeek-nix/main"; };
      tenvideo = { url = "github:GTrunSec/Tenvideo-nix-flake"; inputs.nixpkgs.follows = "nixos"; };
      rust-overlay = { url = "github:oxalica/rust-overlay"; };
      emacsNg-flake = { url = "github:gtrunsec/emacs-ng/nix-webrender"; inputs.flake-utils.follows = "utils"; inputs.rust-overlay.follows = "rust-overlay"; inputs.nixpkgs.follows = "nixos"; };
    };

  outputs =
    inputs@{ deploy
    , nixos
    , nur
    , self
    , utils
    , stable
    , nixpkgs-hardenedlinux
    , photoprism-flake
    , threatbus-flake
    , emacs-overlay
    , vast-flake
    , zeek-nix
    , brim-flake
    , tenvideo
    , emacsNg-flake
    , rust-overlay
    , ...
    }:
    let
      lib = import ./lib { inherit self nixos utils inputs; };
    in
    lib.mkFlake
      {
        inherit self;
        hosts = ./hosts;
        packages = import ./pkgs;
        suites = import ./suites;
        extern = import ./extern;
        overrides = import ./overrides;
        overlays = ./overlays;
        profiles = ./profiles;
        userProfiles = ./users/profiles;
        modules = import ./modules/module-list.nix;
        userModules = import ./users/modules/module-list.nix;
      } // {
      inherit lib;
      defaultTemplate = self.templates.flk;
      templates.flk.path = ./.;
      templates.flk.description = "flk template";
    };
}
