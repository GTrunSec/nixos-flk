let
  gtrun-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKTQ1V9mjPZY31h55Jl6nl7VBxl6cQgag9+s8kvJSEpZ NixOS-gtrun-14-05-2021";
  gtrun-macos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDI2uDp51HMggnfz4Zn5ky4gb/XVdQiJR7pZyb/LcCLx macOSdeMBP.attlocal.net-gtrun-14-05-2021";
  #ssh-keygen -o -a 256 -t ed25519 -C "$(hostname)-$('USER)-$(date +'%d-%m-%Y')"
  #######################
  # Users Authorization #
  #######################
  owner = [ gtrun-nixos gtrun-macos ];
in
{
  "gtrun-user.age".publicKeys = owner;
  "root-user.age".publicKeys = owner;
  "nextcloud-admin.age".publicKeys = owner;
  "nextcloud-db.age".publicKeys = owner;
}
