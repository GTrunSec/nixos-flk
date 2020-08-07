{ pkgs ? import <nixpkgs> {} }:

pkgs.vscode-with-extensions.override {
  # When the extension is already available in the default extensions set.
  vscodeExtensions = with pkgs.vscode-extensions; [
    bbenoist.Nix
  ]
    # Concise version from the vscode market place when not available in the default set.
  ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    #theme
    {
      publisher = "enkia";
      name = "tokyo-night";
      version = "0.3.3";
      sha256 = "0kaqam5mvc7kfz74rajbncb7w2fjqqiimwmy583jnf5vlw2p21in";
    }
    #pdf
    {
      publisher = "tomoki1207";
      name = "pdf";
      version = "0.5.1";
      sha256 = "0bph7gnd6j55r997y62xb7n09cp08i46gmdk0lk5gjbpz3c03hvv";
    }

    #time does not work on nixos
    # {
    #   publisher = "WakaTime";
    #   name = "vscode-wakatime";
    #   version = "4.0.0";
    #   sha256 = "0bwxz8dg00k8frnvkvcngll5yaf9k7z13dg309vmw8xbdgkiyid4";
    # }


    #markdown

    {
      publisher = "DavidAnson";
      name = "vscode-markdownlint";
      version = "0.31.1";
      sha256 = "1jaqfvk09ykm3m7mi4kryhialfy8yxbn122dvrmzlsnyci3xpxzg";
    }

    {
      publisher = "shd101wyy";
      name = "markdown-preview-enhanced";
      version = "0.4.3";
      sha256 = "0l7bp76xhcp017zch98gssrnwh6cc5adbp4d30fkvkf6ipap826s";
    }

    # https://github.com/darkoperator/vscode-sysmon
    # Lang-C
    {
      publisher = "ccls-project";
      name = "ccls";
      version = "0.1.28";
      sha256 = "11zn2pbj4y1j2cnn0yhf2dvhkxy9am8d1ja92grh3h86wvz0mw8k";
    }

    # Lang-julia
    {
      publisher = "julialang";
      name = "language-julia";
      version = "0.15.29";
      sha256 = "12hna9w6403fw2n99x3qk0b46iw7c79bq5gh2yjzn1rcw027xrnl";
    }

    {
      publisher = "cameronbieganek";
      name = "julia-color-themes";
      version = "0.1.1";
      sha256 = "18116yjfxbig6mhbswkx66l207mqks510f70yb36vla23bnw0r6v";
    }

    # Lang-R
    {
      publisher = "Ikuyadeu";
      name = "r";
      version = "1.1.1";
      sha256 = "1rhwq830jyyxqic5a4mb8kyd29lzfjcz5ap51kb4s0s5y3v6l3m8";
    }
    # dotnet-runtime
    # {
    #   publisher = "Mikhail-Arkhipov";
    #   name = "r";
    #   version = "0.0.6";
    #   sha256 = "18a5w0nwicx84y5l14qbbvfd5yh9zi2dcbvclhc51kx3wgkmy29l";
    # }

    {
      publisher = "REditorSupport";
      name = "r-lsp";
      version = "0.1.0";
      sha256 = "0kqh53jx314bsv3x48vyf29blkicr2jdwgz7vj5vklf9zxd3n1pa";
    }

    # Lang-Go
    {
      publisher = "golang";
      name = "Go";
      version = "0.15.1";
      sha256 = "1h7r781asl890n9fc0dh81l4ffx8xqd81d4hy2680dji8x390axz";
    }

    {
      publisher = "premparihar";
      name = "gotestexplorer";
      version = "0.1.10";
      sha256 = "1z4n5hhm5qx97an6s2c7m7vlx5rqvzwqq1ywwz93zdnmlc3v0nks";
    }

    {
      publisher = "ms-python";
      name = "python";
      version = "2020.4.76186";
      sha256 = "0arqz1778hp3sk95f3i1p1kyykpn9y7k1h256jpxn1m4723ccbn6";
    }
    
    {
      name = "matchit";
      publisher = "redguardtoo";
      version = "1.0.1";
      sha256 = "1jjpzr48gpcxx1ic0k1mmvrghpx5drgcl6gh8rwcn57lshzrs4a4";
    }

    {
      name = "bro";
      publisher = "aeppert";
      version = "0.6.0";
      sha256 = "01a2g6n9jq2l9fjcg4pnff94cyhgll16hkn7wxsgkas65cc140pv";

    }


    {
      name = "vscode-emacs-friendly";
      publisher = "lfs";
      version = "0.9.0";
      sha256 = "1j4cy77m1077wdl2vvpmzi98y3jkycvf8z84pscs3lkkk1mvcsv1";

    }

    {
      name = "readable-indent";
      publisher = "cnojima";
      version = "1.2.1";
      sha256 = "08mn7rmcy27vbnphjw7ngi2k4g9rz5waip1kfp8sw7pkvh0gzg1m";

    }

    {
      name = "indent-rainbow";
      publisher = "oderwat";
      version = "7.4.0";
      sha256 = "1xnsdwrcx24vlbpd2igjaqlk3ck5d6jzcfmxaisrgk7sac1aa81p";

    }
    
    {
      name = "rainbow-brackets";
      publisher = "2gua";
      version = "0.0.6";
      sha256 = "1m5c7jjxphawh7dmbzmrwf60dz4swn8c31svbzb5nhaazqbnyl2d";

    }
    
    {
      publisher = "formulahendry";
      name = "code-runner";
      version = "0.9.14";
      sha256 = "15y5ngcncbhssikx90sx9v3z108w2q3bgvk3j7i7w1v04p5i6wsw";

    }

    {
      publisher = "TabNine";
      name = "tabnine-vscode";
      version = "2.1.11";
      sha256 = "0nr8wfxlbb613f29m34jnv1ldfhw6sf5s1pbarmxa7zkkyp46jam";

    }
    #haskell
    # {
    #   publisher = "alanz";
    #   name = "vscode-hie-server";
    #   version = "0.0.31";
    #   sha256 = "115h4b5fsyk1f31daa5r18dpimm0ck2gjg0bal272xbaddbg2idp";

    # }

      #haskell
    { #
      publisher = "justusadam";
      name = "language-haskell";
      version = "2.6.0";
      sha256 = "1891pg4x5qkh151pylvn93c4plqw6vgasa4g40jbma5xzq8pygr4";

    }

    {
      publisher = "DigitalAssetHoldingsLLC";
      name = "ghcide";
      version = "0.0.2";
      sha256 = "02gla0g11qcgd6sjvkiazzk3fq104b38skqrs6hvxcv2fzvm9zwf";

    }
    #haskell
    {
      publisher = "hoovercj";
      name = "haskell-linter";
      version = "0.0.6";
      sha256 = "0fb71cbjx1pyrjhi5ak29wj23b874b5hqjbh68njs61vkr3jlf1j";

    }

    # yara
    {
      publisher = "infosec-intern";
      name = "yara";
      version = "1.3.8";
      sha256 = "0qflr3ajidczfksmpvbnvawcbcf835l4wyix9a9dfch5dj4x0h22";

    }

   ];
}
