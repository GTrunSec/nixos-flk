{...}: {
  services.openssh = {
    enable = true;
    kbdInteractiveAuthentication = false;
    passwordAuthentication = false;
    forwardX11 = true;
  };
}
