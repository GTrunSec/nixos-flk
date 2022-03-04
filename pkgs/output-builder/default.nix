channels: inputs: {
  packages = {
    #nix develop .#sops-shell --impure
    sops-shell = with channels.nixpkgs;
      mkShell {
        sopsPGPKeyDirs = [
          #"./secrets/keys/hosts"
          "./secrets/keys/users"
        ];
        nativeBuildInputs = [sops-import-keys-hook];
      };
  };
}
