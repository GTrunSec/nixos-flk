{
  config,
  lib,
  pkgs,
  ...
}: {
  #nix.generateRegistryFromInputs = lib.mkDefault true;

  nix = {
    package = pkgs.nixUnstable;

    localRegistry = {
      enable = false;

      cacheGlobalRegistry = true;

      noGlobalRegistry = false;
    };

    settings = {
      auto-optimise-store = true;
      max-jobs = lib.mkDefault 12;
      allowed-users = ["@wheel"];
      trusted-users = ["root" "@wheel"];
      system-features = ["nixos-test" "benchmark" "big-parallel" "kvm"];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };

    optimise.automatic = true;

    extraOptions = ''
      min-free = 536870912
      accept-flake-config = true
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';

  };

  #systemd.services.sync-nixpkgs.serviceConfig.TimeoutSec = lib.mkForce 500;
}
