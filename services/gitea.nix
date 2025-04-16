{ config, pkgs, ... }:
{
  containers.gitea = {
    autoStart = true;

    # Configure the container itself
    config = { config, pkgs, ... }: {
      services.gitea = {
        enable = true;
        appName = "Gitea";
        database.type = "sqlite3";
        settings = {
          server = {
            HTTP_PORT = 3001;
            DOMAIN = "git.mechanicus.xyz";
            ROOT_URL = "http://git.mechanicus.xyz/";
          };
        };
      };

      # Open the container firewall for Gitea
      networking.firewall.allowedTCPPorts = [ 3001 ];

      # Same as outside container
      system.stateVersion = "23.11";
    };

    # Bind host port to container
    bindMounts = {
      "/var/lib/gitea" = {
        hostPath = "/var/lib/gitea";
        isReadOnly = false;
      };
    };
  };

  # Forward host port to container
  networking.nat = {
    enable = true;
    internalInterfaces = ["ve-+"];
    externalInterface = "eth0";
  };
}
