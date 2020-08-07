{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (texmacs.override {chineseFonts = true; extraFonts = true;})
    ( texlive.combine # latex + packages
      { inherit (texlive)
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
        fontspec euenc;

      }
    )
  ];
}
