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
        home-packages = digga.lib.rakeLeaves ../users/profiles/home-packages;
      };

    suites = with profiles; rec {
      base = [ common direnv git gpg alacritty shellProfile link-home-file];

      shellProfile = [zsh zoxide fzf starship dircolors direnv tmux lsd];

      graphicalProfile = [cursor randr feh];

      serviceProfile = [lorri dunst dropbox systemd];

      gtrun = [graphicalProfile serviceProfile doom-emacs.nixos home-packages.nixos] ++ base;

      darwinProfile = [doom-emacs.darwin];

      darwin = [base shellProfile home-packages.darwin darwinProfile];
    };
  };
  users = {
    gtrun = {suites, ...}: {imports = suites.gtrun;};
    darwin = {suites, ...}: {imports = suites.darwin;};
    nixos = {suites, ...}: {imports = suites.base;};
  };
}
