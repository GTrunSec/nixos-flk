{ config, lib, pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    settings = {
      default-key = "6A43333DBD6C7C70B7A1DB59761C8EBEA940960E";
      cert-digest-algo = "SHA512";
      disable-cipher-algo = "3DES";
      default-recipient-self = true;
      use-agent = true;
      with-fingerprint = true;
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
