{ lib, config, ...}:
{
  users.users.root.password = config.password.root;
}
