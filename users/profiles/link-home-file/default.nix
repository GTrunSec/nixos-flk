{ config, lib, pkgs, ... }:

{
  config = with lib; mkMerge [

    (mkIf pkgs.stdenv.isLinux {

      home.file.".config/i3/config".source = ../../dotfiles/i3/config;
      home.file.".config/i3/move-cursor-window-center.sh".source = ../../dotfiles/i3/move-cursor-window-center.sh;

      #polyar
      home.file.".config/polybar/".source = ../../dotfiles/polybar;
      # compton
      home.file.".compton.conf".source = ../../dotfiles/.compton.conf;
      # rofi
      home.file.".config/rofi".source = ../../dotfiles/rofi;
      # termite
      home.file.".config/termite/config".source = ../../dotfiles/termite/config;
      # kitty
      home.file.".config/kitty/kitty.conf".source = ../../dotfiles/kitty/kitty.conf;
      # Let Home Manager install and manage itself.
      #programs.home-manager.enable = true;
      # pet
      home.file.".config/pet".source = ../../dotfiles/pet;

      home.file.".config/promnesia/config.py".source = ../../../profiles/data/promnesia/config.py;
    })

    (mkIf pkgs.stdenv.isDarwin {
      home.file.".config/pet/config.toml".source = ../../dotfiles/pet/darwin-config.toml;
      home.file.".config/pet/snippet.toml".source = ../../dotfiles/pet/snippet.toml;
      home.file."Library/Application Support/promnesia/config.py".source = ../../../profiles/data/promnesia/config.py;
    })

    ({ })
  ];
}
