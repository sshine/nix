{ pkgs, lib, config, secrix, ... }: {
  options = { };

  imports = [
    secrix.nixosModules.default
  ];

  config = {
    secrix.defaultEncryptKeys = {
      sshine = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN+WHf94v0BWIlOlPZZVnlWUgx0+s4EgusbXdWRoLvYD sshine@dao" ];
    };

    secrix.hostPubKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqdDq8fdO38+LV4/iph0DKhKrm6OQJRmDM5TiGFgxp4 root@dao";
    # secrix.system.secrets.irc.encrypted.file = ./secrets/irc;
  };
}
