{ pkgs, config, lib, ... }: {
  imports = [
    ./shared/users.nix
    ./shared/home-manager.nix

    ./programs/zsh.nix
    ./programs/vim.nix
    ./programs/irssi.nix
    ./programs/terranix.nix
    ./programs/claude-code.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.flake-registry = "";
  nix.channel.enable = false;
  nixpkgs.config.allowUnfree = true;
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  time.timeZone = "Europe/Copenhagen";

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
    # standard tools
    bat
    curl
    direnv
    fd
    file
    fzf
    htop
    jq
    just
    killall
    ripgrep
    screen
    tree
    watchexec
    wget
    which

    # misc
    ghostty.terminfo

    # nix tools
    deadnix
    nix-output-monitor
    nixpkgs-fmt

    # networking
    dnsutils
    nmap

    # security
    age
    openssl
    sops

    # compression
    gnutar
    unzip
    xz
    zip
    zstd
  ];
}
