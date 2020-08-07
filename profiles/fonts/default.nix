{ pkgs, ... }:
{
    fonts.fonts = with pkgs; [ fantasque-sans-mono
                               noto-fonts
                               noto-fonts-cjk
                               noto-fonts-emoji
                               siji
                               liberation_ttf
	                             fira-code
	                             fira-code-symbols
	                             mplus-outline-fonts
	                             dina-font
	                             proggyfonts
	                             source-han-sans-simplified-chinese
	                             source-han-sans-traditional-chinese
                               material-icons
                               weather-icons
	];
}
