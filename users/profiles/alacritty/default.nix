{
  config,
  lib,
  pkgs,
  ...
}: {
  config = with lib;
    mkMerge [
      {
        programs.alacritty = {
          enable = true;
          settings = {
            env.TERM = "xterm-256color";
            font.normal.style = "Regular";
            cursor.style = "Beam";
            # Background opacity
            window = {
              padding.x = 10;
              padding.y = 10;
              decorations = "none";
              opacity = 0.7;
            };
            # snazzy theme
            colors = {
              # Default colors
              primary = {
                background = "0x282a36";
                foreground = "0xeff0eb";
              };

              # Normal colors
              normal = {
                black = "0x282a36";
                red = "0xff5c57";
                green = "0x5af78e";
                yellow = "0xf3f99d";
                blue = "0x57c7ff";
                magenta = "0xff6ac1";
                cyan = "0x9aedfe";
                white = "0xf1f1f0";
              };

              # Bright colors
              bright = {
                black = "0x686868";
                red = "0xff5c57";
                green = "0x5af78e";
                yellow = "0xf3f99d";
                blue = "0x57c7ff";
                magenta = "0xff6ac1";
                cyan = "0x9aedfe";
                white = "0xf1f1f0";
              };
            };
          };
        };
      }

      (
        mkIf pkgs.stdenv.isLinux {
          programs.alacritty = {
            settings = {
              font.size = 30.0;
              font.normal.family = "Fantasque Sans Mono";
            };
          };
        }
      )

      (
        mkIf pkgs.stdenv.isDarwin {
          programs.alacritty = {
            settings = {
              font.size = 25.0;
              font.normal.family = "Fantasque Sans Mono";
              alt_send_esc = false;
            };
          };
        }
      )
    ];
}
