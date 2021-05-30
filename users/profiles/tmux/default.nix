{ config, pkgs, lib, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    extraConfig = (if pkgs.stdenv.isLinux then ''
    '' else ''
    '') + ''
      unbind C-a
      set -g prefix C-b
      bind C-b send-prefix
      set -g mouse on

      bind P paste-buffer
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle

      set -g @continuum-restore 'on'
    '';

    plugins = with pkgs.tmuxPlugins; [
      sidebar
      yank
      fingers
      sensible
      continuum
      resurrect
      power-theme
    ];
  };
}
