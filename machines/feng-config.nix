{ birthday-rsvp, pkgs, modulesPath, ... }: {
  imports = [
    ../common.nix
    ../services.nix # FIXME(sshine): Enable using options instead.
    ./feng-networking.nix
    ./hetzner-vps-hardware.nix
    birthday-rsvp.nixosModules.default
  ];

  networking.hostName = "feng";
  networking.domain = "mechanicus.xyz";
  system.stateVersion = "23.11";

  services.radicle.enable = true;
  services.vaultwarden.enable = true;

  services.birthday-rsvp = {
    enable = true;
    domain = "party.simonshine.dk";
    secretKey = "change-me";
  };
}
