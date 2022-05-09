{
  self,
  inputs,
  ...
} @ args:
with inputs; {
  hostDefaults = import ./hostDefault.nix args;

  imports = [(digga.lib.importHosts ../hosts/darwin)];

  hosts = import ./hosts.nix args;

  importables = import ./suites.nix args;
}
