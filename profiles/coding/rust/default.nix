{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (rust-bin.nightly.latest.default.override {extensions = ["rust-src"];})
    rust-bin.nightly.latest."rust-analyzer-preview"
  ];
}
