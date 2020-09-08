{ pkgs, ... }:

let
  my-python-packages = (pkgs.python37.withPackages (ps: with ps;[
    pytest
    numpy
    #orgparse
    pytest
    scikitlearn
    #zat
    matplotlib
    sqlalchemy
    pandas
    #voila
    python-language-server
    pygments
    #orgbabelhelper
    jupyter
    jupyterlab
  ])).override (args: { ignoreCollisions = true;});
in
{
  environment.systemPackages = with pkgs; [
    my-python-packages
    wakatime
  ];
}
