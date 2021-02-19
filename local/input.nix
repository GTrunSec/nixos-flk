{ pkgs, ... }:

{
  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx.engines = with pkgs.fcitx-engines; [ cloudpinyin rime ];
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-rime
      ];
    };
  };
}
