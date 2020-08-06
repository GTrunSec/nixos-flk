{ pkgs, ... }:
let inherit (builtins) readFile;
in
{
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.pulseaudio.enable = true;




   services.xserver = {
    enable = true;

    libinput.enable = true;

    displayManager.sddm = {
      enable = true;
      theme = "chili";
    };
    desktopManager.plasma5.enable = true;
    windowManager = {
      i3 = {
        package = pkgs.i3-gaps;
        enable = true;
      };
    };


    videoDrivers = [ "nvidia" "intel"];
    displayManager.autoLogin = {
      enable = true;
      user = "gtrun";
    };

    displayManager.defaultSession = "none+i3";
    desktopManager.xterm.enable = false;

   };


   boot.blacklistedKernelModules = [ "nouveau" ];
   systemd.services.nvidia-control-devices = {
    wantedBy = [
      "multi-user.target"
    ];
   };

}
