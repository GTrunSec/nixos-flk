{
  description = "Darwin OS - A highly awesome system configuration";

  nixConfig = {
    extra-trusted-public-keys = [
      "emacs.cachix.org-1:b1SMJNLY/mZF6GxQE+eDBeps7WnkT0Po55TAyzwOxTY="
    ];
    extra-substituters = [
      "https://emacs.cachix.org"
    ];
  };

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

    emacs.url = "github:cmacrae/emacs";

  };


  outputs = inputs@{ self, nixpkgs, latest, utils, nix-darwin, home, nixpkgs-hardenedliux, emacs }:
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
          emacs.overlay


          (import ../../overlays/nixos/my-node-packages.nix)
          (import ../../overlays/nixos/apps.nix)


          (final: prev: {
            sources = prev.callPackage ../../pkgs/_sources/generated.nix { };
            gst = nixpkgs-hardenedliux.packages.${final.system}.gst;
            lib = prev.lib.extend (lfinal: lprev: {
              installApp = import ../../lib/installApp.nix prev;
            });
          })
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


      outputsBuilder = channels: {
        packages = {
          #nix develop .#sops-shell --impure
          devShell = with channels.nixpkgs;
            mkShell {
              buildInputs = [ cachix ];
            };
        };
      };
    };
}
