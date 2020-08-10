{ pkgs, ... }:

{
  imports = [ ./chat ./misc ./img ];
  environment.systemPackages = with pkgs; [
  ];
}
