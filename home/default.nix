{
  self,
  inputs,
  ...
}: {
  imports = [(inputs.digga.lib.importExportableModules ../users/modules)];
  modules = [];
  importables = rec {
    profiles = inputs.digga.lib.rakeLeaves ../users/profiles;
    suites = with profiles; rec {
      base = [direnv git gpg alacritty shellProfile link-home-file home-packages];

      shellProfile = [zsh zoxide fzf starship dircolors direnv tmux lsd];
      graphicalProfile = [cursor randr];
      serviceProfile = [lorri dunst dropbox systemd];

      gtrun = [graphicalProfile serviceProfile] ++ base;
    };
  };
  users = {
    gtrun = {suites, ...}: {imports = suites.gtrun;};
    darwin = {suites, ...}: {imports = suites.base;};
    nixos = {suites, ...}: {imports = suites.base;};
  };
}
