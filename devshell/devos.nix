{
  pkgs,
  extraModulesPath,
  ...
}: let
  hooks = import ./hooks;

  pkgWithCategory = category: package: {inherit package category;};
  linter = pkgWithCategory "linter";
  docs = pkgWithCategory "docs";
  devos = pkgWithCategory "devos";
in {
  _file = toString ./.;

  imports = ["${extraModulesPath}/git/hooks.nix"];
  git = {inherit hooks;};

  packages = with pkgs; [];

  commands = with pkgs;
    [
      (devos nixUnstable)
    ]
    ++ lib.optional
    (pkgs ? deploy-rs)
    (devos deploy-rs.deploy-rs)
    ++ lib.optional
    (system != "i686-linux")
    (devos cachix);
}
