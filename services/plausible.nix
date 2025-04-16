{ config, pkgs, ... }: {
  services.plausible = {
    enable = true;

    adminUser = {
      activate = true;
      email = "simon@simonshine.dk";
      passwordFile = ./plausible-passwords.db;
      # sops.secrets.services.bla
    };

    server = {
      baseUrl = "https://metrics.nix.tools";
      secretKeybaseFile = ./plausible-keybase.db;
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "plausible" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };
}
