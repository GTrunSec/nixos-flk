{ lib, pkgs, config, inputs, ... }:

{
  home-manager.users.gtrun = { pkgs, config, ... }: {
    imports = [
      ../profiles/link-home-file
      ../profiles/home-packages
      ../profiles/home-packages/home-darwin-packages.nix
      ../profiles/zsh
      ../profiles/tmux
      ../profiles/alacritty
      ../profiles/git
      ../profiles/doom-emacs/doom-emacs-darwin.nix
      ../profiles/gpg
      ../profiles/direnv
    ];
  };
}
