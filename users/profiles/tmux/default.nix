{ config, pkgs, lib, ... }:
let
  #https://github.com/rummik/nixos-config/blob/master/config/home-manager/tmux.nix
  inherit (pkgs) tmuxPlugins tmux;
  inherit (lib) optionalString maybeEnv;
  inherit (pkgs.stdenv) isLinux mkDerivation;
  resurrect-patched = (tmuxPlugins.resurrect.overrideAttrs (oldAttrs: rec {
    src = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tmux-resurrect";
      rev = "e3f05dd34f396a6f81bd9aa02f168e8bbd99e6b2";
      sha256 = "0w7gn6pjcqqhwlv7qa6kkhb011wcrmzv0msh9z7w2y931hla4ppz";
    };

    # patches = [
    #   ../tmux/resurrect-basename-match-strategy.patch
    #   ../tmux/resurrect-cmdline-save-strategy.patch
    # ];
  }));
in
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    extraConfig = /* tmux */(if pkgs.stdenv.isLinux then ''
      set-option -g default-shell /run/current-system/sw/bin/zsh
    '' else ''
      set-option -g default-shell ~/.nix-profile/bin/zsh
    '') + ''

   bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."
   set -gu prefix2
   unbind C-a
   set -g prefix C-b
   bind C-b send-prefix
   set -g mouse on
   set-option -g status-style fg=colour136,bg=colour235
   set -g default-terminal "xterm-256color"
   # default window title colors
   set-window-option -g window-status-style fg=colour244,bg=default #base0 and default
   #set-window-option -g window-status-style dim

# active window title colors
set-window-option -g window-status-current-style fg=colour166,bg=default #orange and default
#set-window-option -g window-status-current-style bright

# pane border
set-option -g pane-border-style fg=colour235 #base02
set-option -g pane-active-border-style fg=colour240 #base01

# message text
set-option -g message-style fg=colour166,bg=colour235 #orange and base02

# pane number display
set-option -g display-panes-active-colour colour33 #blue
set-option -g display-panes-colour colour166 #orange

# clock
  set-window-option -g clock-mode-colour colour64 #green
                  # bell
  set-window-option -g window-status-bell-style fg=colour235,bg=colour160 #base02, red
   # https://www.rushiagr.com/blog/2016/06/16/everything-you-need-to-know-about-tmux-copy-pasting-ubuntu/
   bind P paste-buffer
   bind-key -T copy-mode-vi v send-keys -X begin-selection
   bind-key -T copy-mode-vi y send-keys -X copy-selection
   bind-key -T copy-mode-vi r send-keys -X rectangle-toggle

  '';

    plugins = with tmuxPlugins; [
      {
        plugin = resurrect-patched;
        extraConfig = /* tmux */ ''
          set -g @resurrect-capture-pane-contents "on"
          set -g @resurrect-processes "mosh-client man '~yarn watch'"
          ${optionalString isLinux /* tmux */ ''
          set -g @resurrect-save-command-strategy "cmdline"
          ''}
          set -g @resurrect-process-match-strategy "basename"
          set -g @resurrect-strategy-nvim "session"
        '';
      }
    ];
  };
}
