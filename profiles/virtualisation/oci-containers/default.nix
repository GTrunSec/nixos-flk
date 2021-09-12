{ pkgs, ... }: {

  networking.firewall = {
    allowedTCPPorts = [ 9004 ];
    allowedUDPPorts = [ 9004 ];
  };

  virtualisation.oci-containers.containers = {
    rsshub = {
      image = "diygod/rsshub";
      ports = [ "1200:1200" ];
    };
  };
}
