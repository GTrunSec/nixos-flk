{ pkgs, ... }:
with pkgs;
let

  RPackages = with rPackages;[
    tmap
  ];
    customRPackages = with rPackages;[
    
        bookdown
        devtools
        (let
          llr = buildRPackage {
            name = "llr";
            src = pkgs.fetchFromGitHub {
              owner = "dirkschumacher";
              repo = "llr";
              rev = "0a654d469af231e9017e1100f00df47bae212b2c";
              sha256 = "0ks96m35z73nf2sb1cb8d7dv8hq8dcmxxhc61dnllrwxqq9m36lr";
            };
            propagatedBuildInputs = [ rlang  knitr];
            nativeBuildInputs = [ rlang knitr ];
          };
          patchwork = buildRPackage {
            name = "patchwork";
            src = pkgs.fetchFromGitHub {
              owner = "thomasp85";
              repo = "patchwork";
              rev = "fd7958bae3e7a1e30237c751952e412a0a1d1242";
              sha256 = "00fq520xwy1ysg4k8x48x9b0yy9wyi8y8zj6dvxjg4bwx0yyp6s4";
            };
            propagatedBuildInputs = [ ggplot2 ];
            nativeBuildInputs = [ ggplot2 ]; 
          };
          ##emo
          emo = buildRPackage {
            name = "emo";
            src = pkgs.fetchFromGitHub {
              owner = "hadley";
              repo = "emo";
              rev = "02a520689861c3354f7c6b575e309280b2a3a172";
              sha256 = "0lra8xm06qli2mvr7qnffq703jmlw3xcjy9v71v7inrgjrc0nd3s";
            };
            propagatedBuildInputs = [ rlang lubridate];
            nativeBuildInputs = [ purrr crayon assertthat ]; 
          };

             ##emo
          webreadr = buildRPackage {
            name = "webreadr";
            src = pkgs.fetchFromGitHub {
              owner = "Ironholds";
              repo = "webreadr";
              rev = "5d6be5c6ecc08e09f2a64be1cdebbdea70c35bdb";
              sha256 = "0skhglkf0xxf9lvx6zc0nih0caxrn4r0p1fpd96jji0grp648ayr";
            };
            propagatedBuildInputs = [ rlang];
            nativeBuildInputs = [ Rcpp readr];
          };

        in [
          llr
          webreadr
          patchwork
          #emo
        ])
        ##--------------------------------------
        dplyr
        ggplot2
        xts
        uuid
        htmlwidgets
        IRdisplay
        IRkernel
        languageserver
        parallel
        gtable
        htmltools
        jsonlite
        kableExtra
        KernSmooth
        knitr
        rmarkdown
        labeling
        lazyeval
        magrittr
        markdown
        openssl
        parallel
        Rcpp
        reshape2
        revealjs
        rmarkdown
        tidyr
        tidyselect
        tinytex
        udpipe
        utf8
        #utils
        xml2
        xopen
        yaml
        summarytools
        doBy
        tidyverse
        #map
        rgeolocate
        leaflet
        glue
        pbdZMQ
        #lwgeom

    ];
      R-rstudio-with-my-packages = rstudioWrapper.override{
          packages = [customRPackages];
      };
      
      R-with-my-packages = rWrapper.override{
              packages = customRPackages;

      };
in
{
  environment.systemPackages = with pkgs; [
    R-with-my-packages
    R
    R-rstudio-with-my-packages
    libmaxminddb
  ];

}
