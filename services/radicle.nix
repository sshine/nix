{ pkgs, config, lib, ... }: {
  config = lib.mkIf config.services.radicle.enable {
    networking.firewall.allowedTCPPorts = [ 8776 3010 ];
    services.radicle = {
      privateKeyFile = "/home/sshine/.ssh/id_ed25519";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHa9kX7Px572nm5ULbdUiRzo8nwQMqDaAU9tBUXmhagQ sshine@feng";
      node.openFirewall = true;
      node.listenAddress = "0.0.0.0";
      checkConfig = false;
      httpd.enable = true;
      httpd.listenPort = 3010;

      settings = {
        web.pinned.repositories = [
        ];

        node = {
          alias = "mechanicus.xyz";
          externalAddresses = ["mechanicus.xyz:8776"];
          seedingPolicy = {
            default = "allow";
            scope = "all";
          };
        };
      };
    };
  };
}
