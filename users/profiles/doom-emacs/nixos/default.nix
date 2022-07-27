{
  config,
  lib,
  pkgs,
  ...
}: let
  updatefont = ''fc-cache -f -v'';
  onChange = ''
    export PATH=${config.programs.emacs.finalPackage}/bin/:$PATH
    cd $HOME/.doom.d/
    emacs -Q -batch -l 'lisp/compile.el'
    $HOME/.emacs.d/bin/doom sync
  '';
in {
  home.activation.linkEmacsPrivate = config.lib.dag.entryAfter ["writeBoundary"] ''
     if [ ! -d "$HOME/.emacs.d" ];then
        ${pkgs.git}/bin/git clone https://github.com/hlissner/doom-emacs/ ~/.emacs.d
     fi

    if [ ! -d "$HOME/.doom.d" ];then
    mkdir -p $HOME/.doom.d/
    mkdir -p $HOME/.doom.d/etc
    fi

    if [ ! -d "$HOME/.doom.d/modules" ];then
    ln -sfT "$HOME/.config/guangtao/nixos-flk/users/dotfiles/doom-emacs/lisp" $HOME/.doom.d/lisp
    ln -sfT "$HOME/.config/guangtao/nixos-flk/users/dotfiles/doom-emacs/bin" $HOME/.doom.d/bin
    ln -sfT "$HOME/.config/guangtao/nixos-flk/users/dotfiles/doom-emacs/snippets" $HOME/.doom.d/snippets
    ln -sfT "$HOME/.config/guangtao/nixos-flk/users/dotfiles/doom-emacs/modules" $HOME/.doom.d/modules
    fi

    if [ ! -d "$HOME/.doom.d/modules/my-code" ];then
         mkdir -p $HOME/.doom.d/modules/private/my-org
         mkdir -p $HOME/.doom.d/modules/private/my-code
         mkdir -p $HOME/.doom.d/autoload
    fi
  '';
  # editors
  home.file.".doom.d/config.org" = {
    source = ../../../dotfiles/doom-emacs/config.org;
    inherit onChange;
  };

  home.file.".doom.d/meow.org" = {
    source = ../../../dotfiles/doom-emacs/meow.org;
    inherit onChange;
  };

  programs.emacs.enable = true;

  programs.emacs.package = pkgs.emacsGitNativeComp;

  programs.emacs.extraPackages = epkgs:
    with epkgs; [
      vterm
      grab-x-link
    ];

  # services.emacs.enable = true;
  services.emacs.client.enable = true;
}
