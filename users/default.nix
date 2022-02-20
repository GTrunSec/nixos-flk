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
      base =
        [
          home-services
          direnv
          git
          feh
          zsh
          doom-emacs
          cursor
          alacritty
          tmux
          link-home-file
          home-packages
          randr
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
