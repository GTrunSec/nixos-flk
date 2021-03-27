{ config, lib, pkgs, ... }:
{
  users.users.gtrun = {
    home = "/home/gtrun";
    password = (builtins.fromJSON (builtins.readFile ../../secrets/password.json)).user.gtrun.normal;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "pulse"
      "sound"
      "libvirtd"
      "video"
      "docker"
    ]; # Enable ‘sudo’ for the user.
    shell = "/run/current-system/sw/bin/zsh";
    uid = 1000;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4pdjuq8ISTfHkjP/Kqd6lopZbYOeQqe4JvOlxHHoTZs8eqpdol3uCUszcEQZ/7W7pqes00k1n9R3AqkNssiS6ywtXC9UelIHbPkPoevBMYq8ct5+AZKB6NBEeMMQxEEa9m2UXKTnjr7KMn3kq9CglKo1YJA8gQ0GCuXwkpGxHInY8ea6fwSfCu7CuFNzKkAe+sMm9nrLe6SDkS//UZHuSPBRXyCUHkILx7vDq1g+yFvt4d0DwP2TkJjHWwbnfnBrMxWLwIEBnKGj0C5bnnLiXW3YX/ufEf/S2i5neF2Rh0e7zQAnwpAIVurt3tRiNYzK/araa5NKKXQbLotgfp9lveTjPL1dFusPKUDjtQdTRXza5E2QnHZeRuuKgT4MxMlXfJO2TrJxESTuebbom6w2dcVAxb/WQJr8GpvUhfYVwg2vRua9al72gQnFNlnM8AoJiPdojAV+1J51U5gHEyNUudUV6xRePz5zl1JZIC0Yxe0U+5O3F2RgzWe4w78xzAzk= gtrun@MacBook-Pro.attlocal.net"
    ];
  };
  services.lorri.enable = true;
}
