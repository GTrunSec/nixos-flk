{
  config,
  pkgs,
  suites,
  ...
}: {
  imports = suites.base;

  system.build.applications = pkgs.lib.mkForce (
    pkgs.buildEnv {
      name = "applications";
      paths = config.environment.systemPackages ++ config.home-manager.users."gtrun".home.packages;
      pathsToLink = "/Applications";
    }
  );
}
