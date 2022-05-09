{
  suites,
  pkgs,
  ...
}: {
  ### root password is empty by default ###
  imports =
    suites.nixos
    ++ [
      ./NixOS-hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #networking.nameservers = [ "10.220.170.94" ];

  ## ssd
  services.fstrim.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/Los_Angeles";

  # sudo cp -r ~/.gnupg /var/lib/sops
  sops.gnupg.home = "/home/gtrun/.gnupg";

  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx.engines = with pkgs.fcitx-engines; [cloudpinyin rime];
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-rime
      ];
    };
  };
}
