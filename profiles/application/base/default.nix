{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    #notice
    dunst
    #browwser
    brave

    #book
    polar-bookshelf

    elementary-planner
  ];
}
