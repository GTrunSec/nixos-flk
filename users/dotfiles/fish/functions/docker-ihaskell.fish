function docker-ihaskell
         docker load < (nix-build ~/.config/nixpkgs/home-manager/docker/ihaskell/default.nix)
         docker run -p8888:8888 -it ihaskell-nix:latest
end
