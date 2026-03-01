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

  programs.claude-code.enable = true;
  services.radicle.enable = false;
  services.vaultwarden.enable = true;
  services.oci-registry.enable = false;

  # Nix binary cache server
  services.atticd.enable = true;

  services.birthday-rsvp = {
    enable = true;
    domain = "party.simonshine.dk";
    secretKey = "change-me";
  };
}
