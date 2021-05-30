{
  description = "Sops secrets generatied environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/7d71001b796340b219d1bfa8552c81995017544a";
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    sops-nix.url = github:Mic92/sops-nix;
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, flake-compat, sops-nix }:
    { }
    //
    (flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ]
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlay
              sops-nix.overlay
            ];
            config = { };
          };
        in
        rec {

          devShell = with pkgs; mkShell {
            sopsPGPKeyDirs = [
              #"./keys/hosts"
              "./keys/users"
            ];
            nativeBuildInputs = [ sops-pgp-hook ];
          };
        })
    ) //
    {
      overlay = final: prev: { };
    };
}
