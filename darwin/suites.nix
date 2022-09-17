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
      coding = digga.lib.rakeLeaves ../profiles/coding;
    };
  suites = with profiles; rec {
    base = [core.darwin users.darwin ];
    MacBook =
      base
      ++ [
        coding.rust
        coding.node
        coding.python
      ];
  };
}
