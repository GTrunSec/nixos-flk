{ ... }:
# recommend using `hashedPassword`
{
  users.users.root.password = (builtins.fromJSON (builtins.readFile ../../secrets/password.json)).user.gtrun.root;
}
