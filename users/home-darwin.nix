{ config, lib, pkgs, ... }:

{
  imports = [
    ./profiles/link-home-file
    ./profiles/home-packages
    ./profiles/git
  ];
}
