{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    userName = "GTrunSec";
    userEmail = "gtrunsec@hardenedlinux.org";
    signing.key = "761C8EBEA940960E";
    ignores = [
      ".projectile"
      ".indium.json"
      ".ccls-cache"
      ".Rhistory"
      ".notdeft*"
      "eaf"
      ".auctex-auto"
      "vast.db"
      ".DS_Store"
      "result"
      ".ipynb_checkpoints"
      "__pycache__"
      "*.org.organice-bak"
      ".direnv"
      ".direnv.d"
      ".secrets"
      ".cargo"
    ];
    extraConfig = {

      github = {
        user = "gtrunsec";
      };

      pull = {
        rebase = true;
      };
      merge = {
        ff = "only";
      };
      rebase = {
        autostash = true;
      };
      core = {
        pager = [
          ''
            delta --plus-color="#012800" --minus-color="#340001"
          ''
        ];
      };
      credential = {
        helper = "store";
      };

      interactive = {
        diffFilter = "delta --color-only";
      };
    };
  };
  programs.git.signing.signByDefault = true;
}
