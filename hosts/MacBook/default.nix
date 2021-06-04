{ config, lib, pkgs, inputs, ... }:

{

  users.nix.configureBuildUsers = true;
  services.nix-daemon.enable = true;

  # system.build.applications = pkgs.lib.mkForce (pkgs.buildEnv {
  #   name = "applications";
  #   paths = config.environment.systemPackages ++ config.home-manager.users."gtrun".home.packages;
  #   pathsToLink = "/Applications";
  # });
  system.activationScripts.applications.text = pkgs.lib.mkForce (
    ''
        echo "setting up /Applications/Nix..."
        rm -rf /Applications/Nix
        mkdir -p /Applications/Nix
        chown gtrun /Applications/Nix
        echo "Looking for files in ${config.system.build.applications}/Applications"
        find ${config.system.build.applications}/Applications -maxdepth 1 -type l | while read f; do
          src="$(/usr/bin/stat -f%Y $f)"
          appname="$(basename $src)"
          osascript -e "tell app \"Finder\" to make alias file at POSIX file \"/Applications/Nix/\" to POSIX file \"$src\" with properties {name: \"$appname\"}";
      done
    ''
  );

  nix = {
    package = pkgs.nixFlakes;
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
      user = config.my.username;

      options = "--delete-older-than 7d";
    };
  };

  programs.zsh.enable = true;

  #environment.shells = [ pkgs.zsh ];
}
