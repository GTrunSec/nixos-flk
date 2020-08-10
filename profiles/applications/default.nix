{ pkgs, ... }:

{

  imports = [ ./chat ./misc ./img ];

  environment.systemPackages = with pkgs; [
    #notice
    dunst

    #browwser
    brave

    #book
    polar-bookshelf
    #git manager  UI
    gitkraken

  ];
}
