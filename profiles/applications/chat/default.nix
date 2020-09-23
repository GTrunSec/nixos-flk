{ pkgs, ... }: {

  services.keybase.enable = true;

  services.kbfs = {
    enable = true;
    enableRedirector = true;
  };
  
  environment.systemPackages = with pkgs; [
    discord
    element-desktop
    signal-desktop
    keybase
    keybase-gui
    slack
  ];
}
