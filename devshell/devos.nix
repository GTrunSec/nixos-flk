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

  devshell.startup.nodejs-setuphook = pkgs.lib.stringsWithDeps.noDepEntry ''
    export NODE_PATH=${pkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:$NODE_PATH
  '';

  packages = with pkgs; [];

  commands = with pkgs; [
    (devos nixUnstable)
  ];
}
