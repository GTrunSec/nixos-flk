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

  packages = with pkgs; [
    nixopsUnstable
  ];

  commands = with pkgs;
    [
      (devos nixUnstable)
      # {
      #   category = "devos";
      #   name = pkgs.nvfetcher-bin.pname + "-vscode";
      #   help = pkgs.nvfetcher-bin.meta.description + " to vscode";
      #   command = "cd $PRJ_ROOT/pkgs; ${pkgs.nvfetcher-bin}/bin/nvfetcher -c ./sources-vscode.toml -o ./_sources_vscode $@";
      # }
      # {
      #   category = "devos";
      #   name = pkgs.nvfetcher-bin.pname;
      #   help = pkgs.nvfetcher-bin.meta.description;
      #   command = "cd $PRJ_ROOT/pkgs; ${pkgs.nvfetcher-bin}/bin/nvfetcher -c ./sources.toml $@";
      # }
      (linter nixpkgs-fmt)
      (linter editorconfig-checker)
      # (docs python3Packages.grip) too many deps
    ]
    ++ lib.optional
    (pkgs ? deploy-rs)
    (devos deploy-rs.deploy-rs)
    ++ lib.optional
    (system != "i686-linux")
    (devos cachix);
}
