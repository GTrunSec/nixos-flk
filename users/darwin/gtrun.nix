{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  home-manager.users.gtrun = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      ../profiles/link-home-file
      ../profiles/home-packages
      ../profiles/home-packages/home-darwin-packages.nix
      ../profiles/zsh
      ../profiles/dircolors
      ../profiles/zoxide
      ../profiles/fzf
      ../profiles/tmux
      ../profiles/direnv
      ../profiles/starship
      ../profiles/alacritty
      ../profiles/git
      ../profiles/doom-emacs/doom-emacs-darwin.nix
      ../profiles/gpg
    ];
    home.enableNixpkgsReleaseCheck = false;
  };
}
