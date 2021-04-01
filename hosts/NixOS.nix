{ suites, pkgs, ... }:
{
  ### root password is empty by default ###
  imports = suites.graphics ++ [
    ./hardware/NixOS-hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  environment.etc = {
    "resolv.conf".text = "nameserver 10.220.170.112";
  };

  ## ssd
  services.fstrim.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/Los_Angeles";
  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx.engines = with pkgs.fcitx-engines; [ cloudpinyin rime ];
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-rime
      ];
    };
  };

}
