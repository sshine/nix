{ pkgs, config, lib, ... }: {
  imports = [
    ../programs/zsh.nix
    ../programs/vim.nix
    ../programs/irssi.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.flake-registry = "";
  nix.channel.enable = false;
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
    ports = [ 222 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "yes";
    };
  };

  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
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
