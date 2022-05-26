{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs;
    [
      #customVscode
      #nixFlakes
      shfmt
    ]
    ++ [
      imagemagick
      #library
      libnotify
      #ffmpegthumbnailer
    ]
    ++ [
      coreutils
      #misc
      ghq
      git
      # fdet
      reattach-to-user-namespace
      ispell
      gron
      exa
      pet
      ripgrep
      silver-searcher
      gitAndTools.delta
      (
        bundler.overrideAttrs (
          old: {
            name = "bundler-2.1.4";
            src = pkgs.fetchurl {
              url = "https://rubygems.org/gems/bundler-2.1.4.gem";
              sha256 = "12glbb1357x91fvd004jgkw7ihlkpc9dwr349pd7j83isqhls0ah";
            };
            postFixup = ''
              mv $out/bin/bundle $out/bin/ruby-bundle
              sed -i -e "s/activate_bin_path/bin_path/g" $out/bin/ruby-bundle
            '';
          }
        )
      )
      jekyll
      #emacs org notice
    ]
    ++ [
      #haskell packages
      #flake
    ]
    ++ [
      graphviz
      #nodePackages.mathjax-node-cli
      #nodePackages.mathjax
    ]
    ++ [
      #go packages
    ]
    ++ [
      (
        texlive.combine
        {
          inherit
            (texlive)
            collection-plaingeneric
            collection-latexextra
            collection-fontsrecommended
            collection-pictures
            collection-bibtexextra
            collection-mathscience
            collection-langgerman
            scheme-basic
            xetex
            cjk
            ctex
            xecjk
            dvipng
            fontspec
            euenc
            ;
        }
      )
      vips
    ]
    ++ [
      # darwin Applications
      # logseq-darwin
      polar-darwin
      kitty
    ];
}
