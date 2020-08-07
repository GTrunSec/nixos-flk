{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    feh
    rofi
  ];

  services.xserver = {

    windowManager = {
      i3 = {
        package = pkgs.i3-gaps;
        enable = true;
      };
    };

    displayManager.defaultSession = "none+i3";
    desktopManager.xterm.enable = false;
  };

  nixpkgs.config = {
    pulseaudio = true;
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
        githubSupport = true;
	    };
		};
	};
}
