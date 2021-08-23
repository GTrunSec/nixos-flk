{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    discord
    element-desktop
    signal-desktop
    slack
    # fcitx does not work
    # kotatogram-desktop
    tdesktop
  ];
}
