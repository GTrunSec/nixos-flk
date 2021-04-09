{
  description = "A highly structured configuration database.";

  inputs =
    {
      nixos = { url = "nixpkgs/d09f37cc24e4ec1a567f77e553a298158185182d"; };

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
    , ...
    }:
    let
      inherit (self) lib;
      inherit (lib) os;

      extern = import ./extern { inherit inputs; };
      overrides = import ./overrides;

      multiPkgs = os.mkPkgs {
        inherit extern overrides;
      };

      suites = os.mkSuites {
        suites = import ./suites;
        users = os.mkProfileAttrs "${self}/users";
        profiles = os.mkProfileAttrs "${self}/profiles";
        userProfiles = os.mkProfileAttrs "${self}/users/profiles";
      };

      outputs = {
        nixosConfigurations = os.mkHosts {
          dir = "${self}/hosts";
          overrides = import ./overrides;
          inherit multiPkgs suites extern;
        };

        homeConfigurations = os.mkHomeConfigurations;

        nixosModules =
          let moduleList = import ./modules/module-list.nix;
          in lib.pathsToImportedAttrs moduleList;

        homeModules =
          let moduleList = import ./users/modules/module-list.nix;
          in lib.pathsToImportedAttrs moduleList;

        overlay = import ./pkgs;
        overlays = lib.pathsToImportedAttrs (lib.pathsIn ./overlays);

        lib = import ./lib { inherit nixos self inputs; };

        templates.flk.path = ./.;
        templates.flk.description = "flk template";
        defaultTemplate = self.templates.flk;

        deploy.nodes = os.mkNodes deploy self.nixosConfigurations;
      };

      systemOutputs = utils.lib.eachDefaultSystem (system:
        let
          pkgs = multiPkgs.${system};
          # all packages that are defined in ./pkgs
          legacyPackages = os.mkPackages { inherit pkgs; };
        in
        {
          checks =
            let
              tests = nixos.lib.optionalAttrs (system == "x86_64-linux")
                (import ./tests { inherit self pkgs; });
              deployHosts = nixos.lib.filterAttrs
                (n: _: self.nixosConfigurations.${n}.config.nixpkgs.system == system)
                self.deploy.nodes;
              deployChecks = deploy.lib.${system}.deployChecks { nodes = deployHosts; };
            in
            nixos.lib.recursiveUpdate tests deployChecks;

          inherit legacyPackages;
          packages = lib.filterPackages system legacyPackages;

          devShell = import ./shell {
            inherit self system extern overrides;
          };
        }
      );
    in
    nixos.lib.recursiveUpdate outputs systemOutputs;
}
