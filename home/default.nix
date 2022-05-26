{
  self,
  inputs,
  ...
}: {
  imports = [(inputs.digga.lib.importExportableModules ../users/modules)];

  modules = [];

  importables = with inputs; rec {

    profiles =
      digga.lib.rakeLeaves ../users/profiles
      // {
        doom-emacs = digga.lib.rakeLeaves ../users/profiles/doom-emacs;
      };

    suites = with profiles; rec {

      base = [direnv git gpg alacritty shellProfile link-home-file home-packages];

      shellProfile = [zsh zoxide fzf starship dircolors direnv tmux lsd];

      graphicalProfile = [cursor randr feh];

      serviceProfile = [lorri dunst dropbox systemd];

      gtrun = [graphicalProfile serviceProfile doom-emacs.nixos] ++ base;

      darwinProfile = [doom-emacs.darwin];

      darwin = [base shellProfile];
    };
  };
  users = {
    gtrun = {suites, ...}: {imports = suites.gtrun;};
    darwin = {suites, ...}: {imports = suites.darwin;};
    nixos = {suites, ...}: {imports = suites.base;};
  };
}
