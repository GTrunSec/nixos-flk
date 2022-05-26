{
  self,
  inputs,
  ...
}: {
  imports = [(inputs.digga.lib.importExportableModules ../users/modules)];
  modules = [];
  importables = rec {
    profiles = inputs.digga.lib.rakeLeaves ../users/profiles;
    suites = with profiles; rec {
      base = [direnv git];
    };
  };
  users = {
    guangtao = {suites, ...}: {imports = suites.base;};
    darwin = {suites, ...}: {imports = suites.base;};
    nixos = {suites, ...}: {imports = suites.base;};
  };
}
