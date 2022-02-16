{
  self,
  inputs,
  ...
}:
with inputs;
with inputs.nixos; {
  "MacBook" = {
    # This host will be exported under the flake's `darwinConfigurations` output
    output = "darwinConfigurations";

    # Build host with darwinSystem
    builder = darwin.lib.darwinSystem;

    # This host uses `channels.unstable.{input,overlaysBuilder,config,patches}` attributes instead of `channels.nixpkgs.<...>`
    channelName = "nixpkgs";

    # Host specific configuration. Same as `sharedModules`
    modules = [
      (import ../hosts/MacBook)
      ci-agent.darwinModules.agent-profile
      home.darwinModules.home-manager
    ];
  };
}
