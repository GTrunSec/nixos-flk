{
  lib,
  pkgs,
  ...
}: {
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;

  environment = {
    sessionVariables = {
      # Theme settings
      QT_QPA_PLATFORMTHEME = "gtk2";

      # GDK_SCALE = "2";
      # GDK_DPI_SCALE = "0.5";

      GTK2_RC_FILES = let
        gtk = ''
          gtk-icon-theme-name="Papirus"
          gtk-cursor-theme-name="Adwaita"
          gtk-cursor-theme-size ="128"
        '';
      in [
        "${pkgs.writeText "iconrc" "${gtk}"}"
        "${pkgs.adapta-gtk-theme}/share/themes/Adapta/gtk-2.0/gtkrc"
        "${pkgs.gnome3.gnome-themes-extra}/share/themes/Adwaita/gtk-2.0/gtkrc"
      ];
    };

    systemPackages = with pkgs; [
      adapta-gtk-theme
      dzen2
      ffmpeg-full
      gsettings-desktop-schemas
      networkmanagerapplet
      gnome-themes-extra
      imagemagick
      imlib2
      librsvg
      libsForQt5.qtstyleplugins
      papirus-icon-theme
      pulsemixer
      qt5.qtgraphicaleffects
      # stdmanpages
      xsel
      zathura
      xdotool
      xorg.xwininfo
      krusader
      kdiff3
      krename
      keditbookmarks
      kazam
      obs-studio
    ];
  };

  services.xserver = {
    enable = true;

    libinput.enable = true;

    displayManager.lightdm = {
      enable = true;
    };

    displayManager.autoLogin = {
      enable = true;
      user = "gtrun";
    };
  };
  hardware.video.hidpi.enable = true;
}
