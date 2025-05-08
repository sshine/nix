{ pkgs, ... }:
let
  schemesh-pkg = pkgs.fetchgit {
    url = "https://github.com/cosmos72/schemesh.git";
    rev = "refs/heads/main";
    sha256 = "sha256-P/TuBor8hcn03tzIiGJ2mO1anpyJZ86kC4WH9pnTVS8=";
  };
  schemesh = pkgs.callPackage schemesh-pkg {};
in
{
  imports = [
    ./programs/zsh.nix
    ./programs/vim.nix
    ./programs/irssi.nix
  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    screen
    direnv
    jq
    just
    ripgrep
    xz
    unzip
    zstd
    gnutar
    fzf
    file
    which
    tree
    bat
    dnsutils
    openssl
    age
    sops
    schemesh
    nix-output-monitor
    nmap
  ];

  environment.variables.EDITOR = "vim";
}
