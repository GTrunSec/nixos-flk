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
      core = digga.lib.rakeLeaves ../profiles/core;
    };
  suites = with profiles; rec {
    base = [core.darwin users.darwin];
    MacBook =
      base
      ++ [];
  };
}
