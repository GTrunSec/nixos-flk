{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    package = pkgs.pipewire-bluez-master;
    media-session.package = pkgs.pipewire-bluez-master.mediaSession;
    alsa.enable = true;
    pulse.enable = true;
  };
}
