{ config, pkgs, lib, ... }:
{
  users.users.gtrun = {
    home = "/home/gtrun";
    #password = config.password.user;
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "pulse" "sound" "libvirtd"
                    "video"
                    "docker"
                  ]; # Enable ‘sudo’ for the user.
    shell = "/run/current-system/sw/bin/zsh";
    uid = 1000;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCkSgUxROiIN3k9lBRTXSYqUpHEv+KFTlWhBu4OTASs5sEUtbvUhpn2zeySTNb2SRbFsbECLTmfT2avDC2MeNnbivLAyEEAjSgLcpiwfVithUl2Tx59mFVh2wZs/4jyOQ5uX96kvutiWNb91+kQ27lUXk+3e15mgnKmQTyikENbsqzt79lRqjzj9V0KyuvbccDCcE9ZBSZ9LTKAhelYSZ1PwavsEBdXDZZBBVsRrxyVr1QueitdS3D4bxSBHuwwDHkXK3c/f5GPaYkh6Xnv/RzQkKB2dGu/ulw2up5pLShmGir9PFbhDoPfF/EzE9PbSSZV4EsHhLUu4tRsg4LyBtlN gtrun@GTruN"
    ];
  };
  services.lorri.enable = true;
  services.emacs.enable = true;
}
