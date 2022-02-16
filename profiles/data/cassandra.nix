{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.cassandra = {
    enable = true;
    clusterName = "thp";
    package = pkgs.cassandra_3_11;

    extraConfig = {
      authenticator = "PasswordAuthenticator";
      authorizer = "CassandraAuthorizer";
      role_manager = "CassandraRoleManager";
    };

    remoteJmx = true;

    jmxRoles = [
      {
        username = "thehive";
        password = "thehive-password";
      }
    ];
  };
}
