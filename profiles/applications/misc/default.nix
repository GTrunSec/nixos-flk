{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    goldendict
    # manager password
    enpass
    #media
    mpv

    desktop-file-utils
    #browwser
    brave
  ];
}
