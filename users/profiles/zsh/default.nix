{
  config,
  lib,
  pkgs,
  ...
}: {
  config = with lib;
    mkMerge [
      {
        home.packages = with pkgs; [
          zoxide
        ];

        programs.fzf = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
        };

        programs.zsh = {
          enable = true;
          autocd = true;
          dotDir = ".config/zsh";
          enableAutosuggestions = true;
          enableCompletion = true;
          oh-my-zsh = {
            enable = true;
            plugins = [
              "git"
              "sudo"
              "z"
              "docker"
              "git-flow"
              "history-substring-search"
              "python"
            ];
            theme = "xiong-chiamiov-plus";
          };
          history = {
            path = config.programs.zsh.dotDir + "/.zsh_history";
            share = true;
            save = 10000000;
            ignoreDups = true;
            extended = true;
            size = 10000000;
          };
          shellAliases = with pkgs; {
            l = "exa -lah";
            f = "rg --files";
            E = "env SUDO_EDITOR=\"emacsclient\" sudo -e";
            e = "emacsclient";
            em = "emacs";
            cp = "cp -i";
            mv = "mv -i";
            gst = "${pkgs.gst}/bin/gst";
            cdghq = "cd $(ghq root)/$(ghq list | peco)";
            cdgst = "cd $(gst --short | peco)";
            ##update Nixpkgs
            fp = "git fetch && git pull";
            ag0 = "rg --max-depth=1";
            # so = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*usb/{if (a != \"\") print a;} {a=$NF}\\\')";
            # si = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*pci/{if (a != \"\") print a;} {a=$NF}\\\')";
          };

          initExtraBeforeCompInit =
            (builtins.readFile ../../dotfiles/pre-zsh-Compinit)
            + ''
              eval $(${pkgs.coreutils}/bin/dircolors -b ~/.config/guangtao/nixos-flk/users/dotfiles/LS_COLORS)
            '';

          initExtra =
            (builtins.readFile ../../dotfiles/zshrc)
            + ''
              ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#fdf6e3,bg=#586e75,bold,underline"
            '';

          plugins = [
            {
              name = "fzf-zsh";
              src = pkgs.fzf-zsh;
            }
            {
              name = "zsh-fast-syntax-highlighting";
              src = pkgs.zsh-fast-syntax-highlighting;
            }
            {
              name = "zsh-bd";
              src = pkgs.zsh-bd;
            }
            {
              name = "nix-zsh-completions";
              src = pkgs.nix-zsh-completions;
            }
            {
              name = "zsh-256color";
              src = pkgs.fetchFromGitHub {
                owner = "chrissicool";
                repo = "zsh-256color";
                rev = "9d8fa1015dfa895f2258c2efc668bc7012f06da6";
                sha256 = "14pfg49mzl32ia9i9msw9412301kbdjqrm7gzcryk4wh6j66kps1";
              };
            }
            (
              mkIf pkgs.stdenv.isLinux {
                inherit (pkgs.sources.spaceship-prompt) src;
                name = pkgs.sources.spaceship-prompt.pname;
                file = "spaceship.zsh";
              }
            )
          ];
        };
      }
      (
        mkIf pkgs.stdenv.isLinux
        {
          programs.zsh.initExtra = ''
            SPACESHIP_TIME_SHOW=true
            SPACESHIP_EXIT_CODE_SHOW=true
            SPACESHIP_VI_MODE_SHOW=false
            SPACESHIP_BATTERY_THRESHOLD=30
            setopt HIST_IGNORE_ALL_DUPS
            setopt no_extendedglob
          '';
        }
      )
      (
        mkIf pkgs.stdenv.isDarwin {
          programs.zsh.sessionVariables = {
            PATH = "/usr/bin:/run/current-system/sw/bin//:/usr/local/bin:/sbin/:/usr/sbin/:/run/current-system/etc/profiles/per-user/gtrun/bin/";
            TMUX_TMPDIR = "$HOME/.config/.";
            LANG = "en_US.UTF-8";
            export = "LC_ALL=en_US.UTF-8";
            GNUPGHOME = "$HOME/.gnupg";
            #nix-paths
            NIX_PATH = "nixpkgs=${pkgs.path}";
          };
          programs.zsh.initExtra = ''
            setopt no_extendedglob
          '';
        }
      )
    ];
}
