{hmUsers, ...}: {
  home-manager.users = { gtrun = hmUsers.darwin;};

  users.users.gtrun = {
    description = "default";
  };
}
