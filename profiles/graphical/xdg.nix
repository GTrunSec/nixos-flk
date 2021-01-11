{ config, lib, pkgs, ... }:

{

  environment.etc = {
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

    "xdg/user-dirs.defaults" = {
      text =''
         DESKTOP=Desktop
         DOCUMENTS=Documents
         DOWNLOAD=Downloads
         MUSIC=Music
         PICTURES=Pictures
         PUBLICSHARE=Public
         TEMPLATES=Templates
         VIDEOS=Videos
     '';
    };

    "xdg/mimeapps.list" = {
      text = ''
      [Default Applications]
      inode/directory=org.kde.krusader.desktop
      x-scheme-handler/http=brave-browser.desktop
      x-scheme-handler/https=brave-browser.desktop
      x-scheme-handler/org-protocol=org-protocol.desktop
       '';
    };
  };
}
