{ pkgs, config, lib, ... }: {
  imports = [
    ./shared/users.nix
    ./shared/home-manager.nix
    ./services/atuin.nix # FIXME(sshine): Share services with dendritic pattern: https://github.com/mightyiam/dendritic

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
    fx
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
    unixtools.ifconfig
    dnsutils
    nmap

    # security
    age
    openssl
    sops
    pwgen

    # compression
    gnutar
    unzip
    xz
    zip
    zstd
  ];
}
