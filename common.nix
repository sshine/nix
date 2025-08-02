{pkgs, ...}: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = [
    pkgs.ghostty.terminfo
    pkgs.claude-code
  ];

  nixpkgs.config.allowUnfree = true;
}
