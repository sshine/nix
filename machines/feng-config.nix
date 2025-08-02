{ pkgs, modulesPath, ... }: {
  imports = [
    ../common.nix
    ../services.nix # FIXME(sshine): Enable using options instead.
    ./feng-networking.nix
    ./hetzner-vps-hardware.nix
  ];

  networking.hostName = "feng";
  networking.domain = "mechanicus.xyz";
  system.stateVersion = "23.11";

  services.radicle.enable = true;
  services.vaultwarden.enable = true;
}
