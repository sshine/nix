{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.services.atuin.enable {
    services.atuin.database.createLocally = true;
    services.atuin.openFirewall = true;
    services.atuin.openRegistration = true;
    services.atuin.host = "100.78.212.120"; # FIXME(sshine): Hardcoded tailscale interface for 'dao'
  };
}
