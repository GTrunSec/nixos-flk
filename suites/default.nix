{ users, profiles, userProfiles, ... }:
{
  system = with profiles; rec {
    base = [ users.gtrun users.root ];
    graphics = base ++ [
      core-extend
      graphical
      code
      application
      data
      virt
      fonts
      devices
      network
      search
      ssh
      nsm
    ];
  };
  user = with userProfiles; rec {
    base = [
      default-home
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
    ];
  };
}
