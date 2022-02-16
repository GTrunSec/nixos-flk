{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    imgcat
    gimp
    screenfetch
    exa
    spectacle
  ];
}
