{
  config,
  pkgs,
  lib,
  ...
}: {
  config = with lib;
    mkMerge [
      (
        mkIf pkgs.stdenv.isLinux {
          programs = {
            autorandr = {
              enable = true;
              profiles = {
                "home-1" = {
                  fingerprint = {
                    DP-2 = "00ffffffffffff004c2d000e394d5130261b0104b53d23783a5fb1a2574fa2280f5054bfef80714f810081c08180a9c0b300950001014dd000a0f0703e80302035005f592100001a000000fd001e4b1e873c000a202020202020000000fc00553238483735780a2020202020000000ff004854504a3930323631370a2020018402030ff042105f2309070783010000023a801871382d40582c45005f592100001e565e00a0a0a02950302035005f592100001a04740030f2705a80b0588a005f592100001e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1";
                  };
                  config = {
                    DP-2 = {
                      dpi = 300;
                      enable = true;
                      mode = "3840x2160";
                      position = "0x0";
                      rate = "60.00";
                    };
                  };
                };
              };
            };
          };
        }
      )
    ];
}
