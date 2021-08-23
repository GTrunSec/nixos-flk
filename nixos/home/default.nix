{ self, inputs, ... }:
with inputs;
{
  #################################
  # home-manager Users's Profiles #
  #################################
  imports = [ (digga.lib.importModules ../../users/modules) ];
  externalModules = [ ];
  importables = rec {
    profiles = digga.lib.rakeLeaves ../../users/profiles;
    suites = with profiles; rec {
      base = [
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
      ] ++ services;
      services = [ lorri ];
    };
  };
}
