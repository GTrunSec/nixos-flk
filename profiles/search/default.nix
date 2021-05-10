{ config, lib, pkgs, ... }:

{
  imports = [
    ./hound.nix
  ];

  environment.systemPackages = with pkgs; [
    #mail client
    #thunderbird
  ];
}
