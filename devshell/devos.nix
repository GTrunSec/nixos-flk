{
  pkgs,
  lib,
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

  packages = with pkgs; [
    # formatters
    alejandra
    nodePackages.prettier
    nodePackages.prettier-plugin-toml
    shfmt
  ];
  devshell.startup.nodejs-setuphook =
    lib.stringsWithDeps.noDepEntry
    ''
      export NODE_PATH=${pkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:$NODE_PATH
    '';
  commands = with pkgs; [
    (devos nixUnstable)
  ];
}
