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
      base =
        [
          shellProfile
          home-services

          graphicalProfile

          link-home-file
          home-packages

          git
          feh
          doom-emacs
          alacritty

          gpg
        ]
        ++ services;
      services = [lorri];
    };
  };
  users = {
    # digga.lib.importers.rakeLeaves ./users/hm;
    gtrun = {suites, ...}: {
      imports = suites.base;
      home.enableNixpkgsReleaseCheck = false;
    };
  };
}
