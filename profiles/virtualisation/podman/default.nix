{pkgs, ...}: {
  virtualisation.docker.enable = false;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerSocket.enable = true;
  virtualisation.podman.defaultNetwork.dnsname.enable = true;
  users.extraUsers.gtrun.extraGroups = ["podman"];

  services.dockerRegistry.storagePath = "/SSD-1TB/docker-registry";

  environment.systemPackages = with pkgs; [
    docker-client
  ];
}
