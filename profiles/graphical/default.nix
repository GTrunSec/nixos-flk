{ lib, pkgs, ... }:
let
  inherit (builtins) readFile;
in
{
  imports = [ ./i3.nix ];
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.pulseaudio.enable = true;


  boot = {

    kernelPackages = pkgs.linuxPackages_latest;

    tmpOnTmpfs = true;

    kernel.sysctl."kernel.sysrq" = 1;

  };

  environment = {

    etc = {
      "xdg/gtk-3.0/settings.ini" = {
        text = ''
          [Settings]
          gtk-icon-theme-name=Papirus
          gtk-theme-name=Adapta
          gtk-cursor-theme-name=Adwaita
          gtk-cursor-theme-size=128
        '';
        mode = "444";
      };
    };
    
    sessionVariables = {
      # Theme settings
      QT_QPA_PLATFORMTHEME = "gtk2";

      GTK2_RC_FILES =
        let
          gtk = ''
            gtk-icon-theme-name="Papirus"
            gtk-cursor-theme-name="Adwaita"
            gtk-cursor-theme-size ="128"
          '';
        in
          [
            ("${pkgs.writeText "iconrc" "${gtk}"}")
            "${pkgs.adapta-gtk-theme}/share/themes/Adapta/gtk-2.0/gtkrc"
            "${pkgs.gnome3.gnome-themes-extra}/share/themes/Adwaita/gtk-2.0/gtkrc"
          ];
    };

    systemPackages = with pkgs; [
      adapta-gtk-theme
      dzen2
      feh
      ffmpeg-full
      gsettings-desktop-schemas
      gnome3.adwaita-icon-theme
      gnome3.networkmanagerapplet
      gnome-themes-extra
      imagemagick
      imlib2
      librsvg
      libsForQt5.qtstyleplugins
      manpages
      papirus-icon-theme
      pulsemixer
      qt5.qtgraphicaleffects
      stdmanpages
      xsel
      zathura
      xdotool
      xorg.xwininfo
    ];
  };

  services.xserver = {
    enable = true;

    libinput.enable = true;

    displayManager.sddm = {
      enable = true;
    };

    displayManager.autoLogin = {
      enable = true;
      user = "gtrun";
    };
  };

}
