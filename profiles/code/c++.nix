{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # TCLAP - Templatized Command Line Argument Parser
    tclap
    ccls
  ];
}
