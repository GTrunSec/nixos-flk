{pkgs}:
pkgs.vscode-with-extensions.override {
  # When the extension is already available in the default extensions set.
  vscodeExtensions = with pkgs.vscode-extensions;
    [
      bbenoist
      nickel-syntax
      multi-cursor-case-preserve
      # theme
      tokyo-night
      vscode-emacs-friendly
      zeek
      indent-rainbow
      readable-indent
      # Julia
      julia-color-themes
      language-julia
      pdf
      vscode-markdownlint
      markdown-preview-enhanced
      vscode-direnv

      copilot
      # language-rust
      rust-analyzer
    ]
    # Concise version from the vscode market place when not available in the default set.
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [];
}
