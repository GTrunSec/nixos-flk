{ lib, ... }:

{
  options.password = with lib; {
    ##pwgen -yB 24
    user = mkOption {
      type = types.str;
      default = (builtins.fromJSON (builtins.readFile  ../secrets/password.json)).user.normal;
      description = "the password for user";
    };

    root = mkOption {
      type = types.str;
      default = (builtins.fromJSON (builtins.readFile ../secrets/password.json)).user.root;
      description = "the password for user";
    };
  };
}
