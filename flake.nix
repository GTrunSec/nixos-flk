{
  description = "A highly structured configuration database.";

  inputs =
    {
      nixos = { url = "nixpkgs/b702a56d417647de4090ac56c0f18bdc7e646610"; };

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
      utils.url = "github:numtide/flake-utils/flatten-tree-system";
      pkgs.url = "path:./pkgs";
      pkgs.inputs.nixpkgs.follows = "nixos";


      #User's custom flakes
      stable.url = "nixpkgs/684d5d27136f154775c95005dcce2d32943c7c9e";
      photoprism-flake = { url = "github:GTrunSec/photoprism-flake"; inputs.nixpkgs.follows = "stable"; };
      nixpkgs-hardenedlinux = { url = "github:hardenedlinux/nixpkgs-hardenedlinux"; flake = false; };
      brim-flake = { url = "github:hardenedlinux/brim-flake"; inputs.nixpkgs.follows = "nixos"; };
      vast-flake = { url = "github:GTrunSec/vast/nix-flake"; };
      zeek-nix = {
        url = "github:hardenedlinux/zeek-nix/main";
        inputs.nixpkgs.follows = "nixos";
      };
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

      multiPkgs = os.mkPkgs;

      outputs = {
        nixosConfigurations =
          import ./hosts (nixos.lib.recursiveUpdate inputs {
            inherit multiPkgs extern;
            defaultSystem = "x86_64-linux";
            lib = nixos.lib.extend (final: prev: {
              dev = self.lib;
            });
          });

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
        let pkgs = multiPkgs.${system}; in
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

          packages = utils.lib.flattenTreeSystem system
            (os.mkPackages { inherit pkgs; });

          devShell = import ./shell {
            inherit self system;
          };
        }
      );
    in
    nixos.lib.recursiveUpdate outputs systemOutputs;
}
