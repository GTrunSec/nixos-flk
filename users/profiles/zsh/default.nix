{ config, lib, pkgs, ... }:
{
  config = with lib; mkMerge [
    ({
      home.packages = with pkgs;[
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
        enableAutosuggestions = true;
        enableCompletion = true;
        dotDir = ".config/zsh";
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
          share = true;
          path = config.programs.zsh.dotDir + "/.zsh_history";
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
          ##update Nixpkgs
          fp = "git fetch && git pull";
          ag0 = "rg --max-depth=1";
          pcat = "${python3Packages.pygments}/bin/pygmentize";
          # so = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*usb/{if (a != \"\") print a;} {a=$NF}\\\')";
          # si = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*pci/{if (a != \"\") print a;} {a=$NF}\\\')";
        };

        initExtraBeforeCompInit = (builtins.readFile ../../dotfiles/pre-zsh-Compinit) + ''
          eval $(${pkgs.coreutils}/bin/dircolors -b ~/.config/nixpkgs/nixos-flk/users/dotfiles/LS_COLORS)
        '';

        initExtra = (builtins.readFile ../../dotfiles/zshrc) +
          ''
            ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#fdf6e3,bg=#586e75,bold,underline"
            source ${pkgs.nixUnstable.src}/misc/zsh/completion.zsh
          ''
        ;

        plugins =
          [
            {
              name = "fzf-zsh";
              src = pkgs.fzf-zsh;
            }
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
            (mkIf pkgs.stdenv.isLinux {
              name = "spaceship";
              file = "spaceship.zsh";
              src = pkgs.fetchgit {
                url = "https://github.com/denysdovhan/spaceship-prompt";
                rev = "v3.11.1";
                sha256 = "0habry3r6wfbd9xbhw10qfdar3h5chjffr5pib4bx7j4iqcl8lw8";
              };
            })
          ];
      };
    })
    (mkIf
      pkgs.stdenv.isLinux
      {
        programs.zsh.initExtra = ''
          SPACESHIP_TIME_SHOW=true
          SPACESHIP_EXIT_CODE_SHOW=true
          SPACESHIP_VI_MODE_SHOW=false
          SPACESHIP_BATTERY_THRESHOLD=30
          setopt HIST_IGNORE_ALL_DUPS
          setopt no_extendedglob
        '';
      })
    (mkIf pkgs.stdenv.isDarwin {
      programs.zsh.sessionVariables = {
        PATH = "$HOME/.nix-profile/bin:/bin:/usr/bin:/run/current-system/sw/bin/:/usr/local/bin:/Applications/kitty.app/Contents/MacOS:/sbin/:/usr/sbin/:/run/current-system/etc/profiles/per-user/gtrun/bin/";
        TMUX_TMPDIR = "$HOME/.config/.";
        LANG = "en_US.UTF-8";
        export = "LC_ALL=en_US.UTF-8";
        GNUPGHOME = "$HOME/.gnupg";
      };
      programs.zsh.initExtra = ''
        source  ~/.nix-profile/etc/profile.d/nix.sh
        setopt no_extendedglob
      '';
    })
  ];
}
