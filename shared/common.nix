{ pkgs, config, lib, ... }: {
  imports = [
    ./zsh.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  security.sudo = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };

  services.openssh = {
    enable = true;
    ports = [222];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "yes";
    };
  };

  services.tailscale.enable = true;

  environment.variables.EDITOR = "vim";

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    htop
    killall
    screen
    jq
    just
    ripgrep
    xz
    zip
    unzip
    zstd
    gnutar
    file
    which
    tree
    bat
    dnsutils
    openssl
    watchexec
    nmap
  ];
}
