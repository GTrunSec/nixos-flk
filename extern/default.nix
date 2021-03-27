{ inputs }: with inputs;
{
  modules = [
    home.nixosModules.home-manager
    ci-agent.nixosModules.agent-profile

    #User's custom modules
    photoprism-flake.nixosModules.photoprism
    vast-flake.nixosModules.vast
  ] ++ [
    (import ../modules/adguardhome/default.nix)
    (import ../modules/services/zeek)
  ];

  overlays = [
    nur.overlay
    devshell.overlay
    (final: prev: {
      deploy-rs = deploy.packages.${prev.system}.deploy-rs;
    })
    pkgs.overlay

    #User custom pkgs
    tenvideo.overlay
    zeek-nix.overlay
  ];

  # passed to all nixos modules
  specialArgs = {
    overrideModulesPath = "${override}/nixos/modules";
    hardware = nixos-hardware.nixosModules;
  };

  # added to home-manager
  userModules = [
  ];

  # passed to all home-manager modules
  userSpecialArgs = { };
}
