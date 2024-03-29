{
  pkgs,
  config,
  lib,
  self,
  ...
}: {
  programs.zsh.enable = true;

  environment.shellInit = ''
    export STARSHIP_CONFIG=${
      pkgs.writeText "starship.toml"
      (lib.fileContents ../../../users/profiles/starship/starship.toml)
    }
  '';

  environment.shellAliases = let
    ifSudo = lib.mkIf config.security.sudo.enable;
  in {
    # quick cd
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";

    # git
    g = "git";

    # grep
    grep = "rg";
    gi = "grep -i";

    # internet ip
    myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";

    # nix
    n = "nix";
    np = "n profile";
    ni = "np install";
    nr = "np remove";
    ns = "n search --no-update-lock-file";
    nf = "n flake";
    nepl = "n repl '<nixpkgs>'";
    srch = "ns nixos";
    orch = "ns override";
    nrb = ifSudo "sudo nixos-rebuild";
    mn = ''
      manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | sk --preview="manix '{}'" | xargs manix
    '';

    # fix nixos-option
    nixos-option = "nixos-option -I nixpkgs=${self}/lib/compat";

    # sudo
    s = ifSudo "sudo -E ";
    si = ifSudo "sudo -i";
    se = ifSudo "sudoedit";

    # top
    top = "gotop";

    # systemd
    ctl = "systemctl";
    stl = ifSudo "s systemctl";
    utl = "systemctl --user";
    ut = "systemctl --user start";
    un = "systemctl --user stop";
    up = ifSudo "s systemctl start";
    dn = ifSudo "s systemctl stop";
    jtl = "journalctl";
  };

  programs.bash = {
    promptInit = ''
      eval "$(${pkgs.starship}/bin/starship init bash)"
    '';
    interactiveShellInit = ''
      eval "$(${pkgs.direnv}/bin/direnv hook bash)"
    '';
  };
}
