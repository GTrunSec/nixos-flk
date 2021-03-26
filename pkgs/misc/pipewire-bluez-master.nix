{ pipewire
, alsaLib
, dbus
, glib
, libjack2
, libsndfile
, ncurses
, udev
, vulkan-headers
, vulkan-loader
, valgrind
, SDL2
, systemd
, gst_all_1
, ffmpeg
, bluez-master
, libopenaptx
, ldacbt
, sbc
, fdk_aac
}:

pipewire.overrideAttrs (oldAttrs: rec {
  buildInputs = [
    alsaLib
    dbus
    glib
    libjack2
    libsndfile
    ncurses
    udev
    vulkan-headers
    vulkan-loader
    valgrind
    SDL2
    systemd
    gst_all_1.gst-plugins-base
    gst_all_1.gstreamer
    ffmpeg
    bluez-master
    libopenaptx
    ldacbt
    sbc
    fdk_aac
  ];
})
