{ config, lib, pkgs, ... }:
let
  updatefont = ''fc-cache -f -v'';
  updateDoom = ".emacs.d/bin/doom sync";
  updateInit = "bash .doom.d/bin/emacs.sh";
in
{
  home.activation.linkEmacsPrivate = config.lib.dag.entryAfter [ "writeBoundary" ] ''
     if [ ! -d "$HOME/.emacs.d" ];then
        ${pkgs.git}/bin/git clone https://github.com/GTrunSec/doom-emacs.git -b my-doom ~/.emacs.d
     fi

    if [ ! -d "$HOME/.doom.d" ];then
    mkdir -p $HOME/.doom.d/
    mkdir -p $HOME/.doom.d/etc
    fi

    if [ ! -d "$HOME/.doom.d/modules" ];then
    ln -sfT "$HOME/.config/nixpkgs/nixos-flk/users/dotfiles/doom-emacs/lisp" $HOME/.doom.d/lisp
    ln -sfT "$HOME/.config/nixpkgs/nixos-flk/users/dotfiles/doom-emacs/bin" $HOME/.doom.d/bin
    ln -sfT "$HOME/.config/nixpkgs/nixos-flk/users/dotfiles/doom-emacs/snippets" $HOME/.doom.d/snippets
    ln -sfT "$HOME/.config/nixpkgs/nixos-flk/users/dotfiles/doom-emacs/modules" $HOME/.doom.d/modules
    ln -sfT "$HOME/.config/nixpkgs/nixos-flk/users/dotfiles/doom-emacs/Makefile" $HOME/.doom.d/Makefile
    fi

    if [ ! -d "$HOME/.doom.d/modules/my-code" ];then
         mkdir -p $HOME/.doom.d/modules/private/my-org
         mkdir -p $HOME/.doom.d/modules/private/my-code
         mkdir -p $HOME/.doom.d/autoload
    fi
  '';
  # editors
  home.file.".doom.d/config.org" = {
    source = ../../dotfiles/doom-emacs/config.org;
    onChange = updateInit;
  };

  home.file.".doom.d/meow.org" = {
    source = ../../dotfiles/doom-emacs/meow.org;
    onChange = updateInit;
  };

  programs.emacs.enable = true;

  programs.emacs.package = (pkgs.emacsNg.override ({ })).overrideAttrs (old: rec {
    configureFlags = (old.configureFlags or [ ]) ++ [
    ];
  });

  programs.emacs.extraPackages = epkgs: with epkgs;[
    vterm
    grab-x-link
  ];

  services.emacs.enable = true;
}
