{ config, lib, pkgs, ... }:

{
  #nix.generateRegistryFromInputs = lib.mkDefault true;

  nix = {
    package = pkgs.nixUnstable;

    localRegistry =
      {
        enable = false;

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
  #systemd.services.sync-nixpkgs.serviceConfig.TimeoutSec = lib.mkForce 500;
}
