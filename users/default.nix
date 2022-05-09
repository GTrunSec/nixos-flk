{
  self,
  inputs,
  ...
}:
with inputs; {
  #################################
  # home-manager Users's Profiles #
  #################################
  imports = [(digga.lib.importExportableModules ./modules)];
  modules = [];
  importables = rec {
    profiles = digga.lib.rakeLeaves ./profiles;
    suites = with profiles; rec {
      shellProfile = [zsh zoxide fzf starship dircolors direnv tmux lsd];
      graphicalProfile = [cursor randr];
      base = [
        shellProfile

        link-home-file
        home-packages

        git
        alacritty
        gpg
      ];
      services = [lorri dunst dropbox systemd];
      nixos = [doom-emacs feh graphicalProfile] ++ base ++ services;
    };
  };
  users = {
    # digga.lib.importers.rakeLeaves ./users/hm;
    gtrun = {suites, ...}: {
      imports = suites.nixos;
      home.enableNixpkgsReleaseCheck = false;
    };
    taoDarwin = {suites, ...}: {imports = suites.base;};
  };
}
