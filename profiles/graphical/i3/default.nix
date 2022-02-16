{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    rofi
    (
      polybar.override {
        i3Support = true;
        githubSupport = true;
        pulseSupport = true;
        mpdSupport = true;
        alsaSupport = true;
      }
    )
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
}
