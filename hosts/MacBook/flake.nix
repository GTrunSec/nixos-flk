{
  description = "Darwin OS - A highly awesome system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/release-21.05";
    latest.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/staging";

    nix-darwin.url = "github:LnL7/nix-darwin";
    home = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-hardenedliux = { url = "github:hardenedlinux/nixpkgs-hardenedlinux"; };
  };


  outputs = inputs@{ self, nixpkgs, latest, utils, nix-darwin, home, nixpkgs-hardenedliux }:
    let
      inherit (nixpkgs) lib;
    in
    utils.lib.systemFlake {

      # `self` and `inputs` arguments are REQUIRED!!!!!!!!!!!!!!
      inherit self inputs;

      # Shared overlays between channels, gets applied to all `channels.<name>.input`
      sharedOverlays =
        [
          # Overlay imported from `./overlays`. (Defined above)
          self.overlay
          (final: prev: { sources = (import ../../pkgs/_sources/generated.nix) { inherit (final) fetchurl fetchgit; }; })
          (import ../../overlays/nixos/my-node-packages.nix)
          nixpkgs-hardenedliux.overlay
        ];

      # Channel definitions. `channels.<name>.{input,overlaysBuilder,config,patches}`
      channels.nixpkgs = {
        input = nixpkgs;
      };

      channels.latest = {
        input = latest;
      };

      # Default configuration values for `channels.<name>.config = {...}`
      channelsConfig = {
        allowUnsupportedSystem = true;
        allowUnfree = true;
      };

      # Channel specific overlays
      channels.nixpkgs.overlaysBuilder = channels: [
        (final: prev: {
          # Overwrites specified packages to be used from unstable channel.
          inherit (channels.latest) alacritty;
        })
      ];


      # Shared modules/configurations between `hosts`
      hostDefaults = {
        modules = [
          # Sets sane `nix.*` defaults. Please refer to implementation/readme for more details.
          utils.nixosModules.saneFlakeDefaults
          #(import rootDir + "/users/modules/darwin-module-list.nix")
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };


      hosts."MacBook" = {
        # This host will be exported under the flake's `darwinConfigurations` output
        output = "darwinConfigurations";

        # Build host with darwinSystem. `removeAttrs` workaround due to https://github.com/LnL7/nix-darwin/issues/319
        builder = args: nix-darwin.lib.darwinSystem (builtins.removeAttrs args [ "system" ]);

        system = "x86_64-darwin";

        # This host uses `channels.unstable.{input,overlaysBuilder,config,patches}` attributes instead of `channels.nixpkgs.<...>`
        channelName = "nixpkgs";

        # Host specific configuration.
        modules = [
          home.darwinModules.home-manager
          ./.
          ../../users/darwin/gtrun.nix
        ];
      };

      overlay = import ../../pkgs;
    };
}
