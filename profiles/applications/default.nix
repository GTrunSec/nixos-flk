{ pkgs, ... }:

{
  imports = [ ./chat ./misc ];
  environment.systemPackages = with pkgs; [

  ];
}