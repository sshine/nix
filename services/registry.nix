{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.oci-registry;
in
{
  options.services.oci-registry = {
    enable = mkEnableOption "OCI image registry using Podman";

    port = mkOption {
      type = types.port;
      default = 5000;
      description = "Port to bind the registry to";
    };

    host = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "Hostname/IP to bind the registry to";
    };

    dataDir = mkOption {
      type = types.str;
      default = "/var/lib/registry";
      description = "Directory to store registry data";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to open the registry port in the firewall";
    };
  };

  config = mkIf cfg.enable {
    # Enable Podman
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    # Create data directory
    systemd.tmpfiles.rules = [
      "d ${cfg.dataDir} 0755 root root -"
    ];

    # Registry systemd service
    systemd.services.oci-registry = {
      description = "OCI Image Registry";
      after = [ "network.target" "podman.service" ];
      requires = [ "podman.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "exec";
        ExecStart = "${pkgs.podman}/bin/podman run --rm --name registry -p ${cfg.host}:${toString cfg.port}:5000 -v ${cfg.dataDir}:/var/lib/registry registry:2";
        ExecStop = "${pkgs.podman}/bin/podman stop registry";
        ExecStopPost = "${pkgs.podman}/bin/podman rm -f registry";
        Restart = "always";
        RestartSec = "10s";
        User = "root";
        Group = "root";
      };

      preStart = ''
        # Pull the registry image if it doesn't exist
        if ! ${pkgs.podman}/bin/podman image exists registry:2; then
          ${pkgs.podman}/bin/podman pull registry:2
        fi
        
        # Stop and remove any existing registry container
        ${pkgs.podman}/bin/podman stop registry 2>/dev/null || true
        ${pkgs.podman}/bin/podman rm registry 2>/dev/null || true
      '';
    };

    # Open firewall if requested
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];
  };
}
