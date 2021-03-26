{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lxqt.pavucontrol-qt
  ];

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez-master;
    powerOnBoot = true;
    # config = ''
    #     ControllerMode = bredr
    #     AutoConnect=true
    #     [Headset]
    #     HFP=true
    #     MaxConnected=1
    #     FastConnectable=true
    #     '';
  };
  services.blueman.enable = true;
}
