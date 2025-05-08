{ pkgs, lib, config, ... }: {
  config = lib.mkIf config.services.vaultwarden.enable {
    services.vaultwarden = {
      backupDir = "/home/sshine/Projects/vaultwarden";
      dbBackend = "sqlite";
      config = {
        ROCKET_ADDRESS = "0.0.0.0";
        ROCKET_PORT = 8222;
        DOMAIN = "https://vault.mechanicus.xyz";
        SIGNUPS_ALLOWED = true;
        ADMIN_TOKEN = "$argon2id$v=19$m=65540,t=3,p=4$b0Eh0TN084Zl7HEIbp/uBEAGQoX05r/mDb8seXkgqMw$FSJzG+Vzqbm7Yb6sFtAtUP5UeIDqo1tx6LKYtbxBwmk";
        LOG_FILE = "/home/sshine/Projects/vaultwarden/access.log";
      };
    };

    environment.systemPackages = [
      pkgs.vaultwarden
    ];
  };
}
