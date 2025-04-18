{ pkgs, config, lib, ... }: {

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  services.openssh.enable = true;
}
