{
  self,
  inputs,
  ...
}:
with inputs; rec {
  profiles =
    digga.lib.rakeLeaves ../profiles
    // {
      users = digga.lib.rakeLeaves ../users;
    };
  suites = with profiles; rec {
    base = [core.darwin users.darwin];
    MacBook =
      base
      ++ [];
  };
}
