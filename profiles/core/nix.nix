{ config, lib, pkgs, ... }:

{
  nix = {
    package = pkgs.nixUnstable;

    localRegistry =
      {
        enable = true;

        cacheGlobalRegistry = true;

        noGlobalRegistry = false;
      };

    autoOptimiseStore = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };

    optimise.automatic = true;

    useSandbox = true;

    allowedUsers = [ "@wheel" ];

    trustedUsers = [ "root" "@wheel" ];

    extraOptions = ''
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';

    systemFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
  };
}
