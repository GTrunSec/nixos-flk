{ inputs }: with inputs;
{
  modules = [
    home.nixosModules.home-manager
    ci-agent.nixosModules.agent-profile

    #User's custom modules
    photoprism-flake.nixosModules.photoprism
  ];

  overlays = [
    nur.overlay
    devshell.overlay
    tenvideo.overlay
    (final: prev: {
      deploy-rs = deploy.packages.${prev.system}.deploy-rs;
    })
    pkgs.overlay
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
