{ pkgs, config, lib, ... }: {
  imports = [
    ./zsh.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  security.sudo = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };

  services.openssh.enable = true;
}
