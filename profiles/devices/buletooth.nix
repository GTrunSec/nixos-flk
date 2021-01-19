{  pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lxqt.pavucontrol-qt
  ];
  hardware.bluetooth = {
    enable = true;
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

	hardware.pulseaudio = {
	  enable = true;
	  support32Bit = true;
	};

  services.blueman.enable = true;

  hardware.pulseaudio.package = pkgs.pulseaudioFull;
}
