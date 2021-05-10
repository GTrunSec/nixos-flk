{ pkgs, ... }:

{
  imports = [
    ./zeek-deploy.nix
    ./tenzir-infra.nix
  ];

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

  programs.dconf.enable = true; #for brim to dfconf service

  services.elasticsearch = {
    enable = true;
    package = pkgs.elasticsearch7;
    extraConf = ''
      '';
  };

}
