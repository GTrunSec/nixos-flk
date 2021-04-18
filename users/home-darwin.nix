{ config, lib, pkgs, ... }:

{
  imports = [
    ./profiles/link-home-file
    ./profiles/home-packages
    ./profiles/zsh
    ./profiles/tmux
    ./profiles/alacritty
  ];
}
