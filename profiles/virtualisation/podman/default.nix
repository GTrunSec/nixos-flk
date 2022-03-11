{pkgs, ...}: {
  virtualisation.docker.enable = false;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerSocket.enable = true;
  virtualisation.podman.defaultNetwork.dnsname.enable = true;
  users.extraUsers.gtrun.extraGroups = ["podman"];

  environment.systemPackages = with pkgs; [
    docker-client
  ];
}
