{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    screen
    direnv
    jq
    just
    ripgrep
    xz unzip zstd gnutar
    fzf
    file
    which
    tree
    bat
    dnsutils
  ];

  environment.variables.EDITOR = "vim";
}
