{ config, lib, pkgs, inputs, ... }:

{

  users.nix.configureBuildUsers = true;

  services.nix-daemon.enable = true;

  system.build.applications = pkgs.lib.mkForce (pkgs.buildEnv {
    name = "applications";
    paths = config.environment.systemPackages ++ config.home-manager.users."gtrun".home.packages;
    pathsToLink = "/Applications";
  });

  nix = {
    package = pkgs.nixUnstable.overrideAttrs
      (o: {
        patches = (o.patches or [ ]) ++ [
          # fixes nested `inputs.<name>.follows` syntax
          (pkgs.fetchpatch {
            name = "fix-follows.diff";
            url = "https://patch-diff.githubusercontent.com/raw/NixOS/nix/pull/4641.patch";
            sha256 = "sha256-0xNgbyWFmD3UIHPNFrgKiSejGJfuVj1OjqbS1ReLJRc=";
          })
        ];
      });

    registry.nixpkgs.flake = inputs.nixpkgs;

    readOnlyStore = true;

    extraOptions = ''
      experimental-features = nix-command flakes ca-references
      keep-derivations = true
      keep-outputs = true
    '';

    gc = {
      # Automatically run the Nix garbage collector.
      automatic = false;

      # Run the collector as the current user.
      user = "gtrun";

      options = "--delete-older-than 7d";
    };
  };

  #programs.zsh.enable = true;

  #environment.shells = [ pkgs.zsh ];
}
