{ config, ... }:
# recommend using `hashedPassword`
{
  age.secrets.root-password = {
    owner = "root";
    file = ../../secrets/root-user.age;
  };
  users.users.root = {
    passwordFile = config.age.secrets.root-password.path;
  };
}
