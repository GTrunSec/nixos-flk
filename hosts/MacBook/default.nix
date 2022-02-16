{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ ./binaryCaches.nix ];

  users.nix.configureBuildUsers = true;

  services.nix-daemon.enable = true;

  system.build.applications = pkgs.lib.mkForce (
    pkgs.buildEnv {
      name = "applications";
      paths = config.environment.systemPackages ++ config.home-manager.users."gtrun".home.packages;
      pathsToLink = "/Applications";
    }
  );

  nix = {
    package = pkgs.nixUnstable;

    registry.nixpkgs.flake = inputs.nixpkgs;

    readOnlyStore = true;

    extraOptions = ''
      keep-derivations = true
      keep-outputs = true
    '';

    gc = {
      # Automatically run the Nix garbage collector.
      automatic = false;

      # Run the collector as the current user.
      user = "gtrun";

      options = "--delete-older-than 3d";
    };
  };

  #programs.zsh.enable = true;

  #environment.shells = [ pkgs.zsh ];
}
