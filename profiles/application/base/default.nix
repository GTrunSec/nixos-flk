{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    #notice
    dunst
    #browwser
    brave

    #book
    # polar-bookshelf
    foliate
    elementary-planner
  ];
}
