{
  pkgs,
  ...
}:
{
  imports = [ ];

  environment.systemPackages = with pkgs; [
    #home
    sudo-pair
    #btest
    brim
    tcpdump
    wireshark
  ];

  services.dbus = {
    enable = true;
  };

  programs.dconf.enable = true;
  #for brim to dfconf service
}
