{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.kernel.sysctl = {
    "fs.inotify.max_queued_events" = 1048576;
    "fs.inotify.max_user_instances" = 1048576;
    "fs.inotify.max_user_watches" = 1048576;
    "vm.max_map_count" = 262144;
    "kernel.dmesg_restrict" = 1;
    "net.ipv4.neigh.default.gc_thresh3" = 8192;
    "net.ipv6.neigh.default.gc_thresh3" = 8192;
    "kernel.keys.maxkeys" = 2000;
  };
}
