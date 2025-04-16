{ config, pkgs, ... }:
let
  domain' = "grafana.mechanicus.xyz";
  addr = "127.0.0.1";
  port = 2342;
in
{
  services.grafana.enable = true;
  services.grafana.settings.server = {
    domain = domain';
    http_addr = addr;
    http_port = port;
  };

  services.nginx.virtualHosts.${domain'} = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://${addr}:${toString port}";
      proxyWebsockets = true;
    };
  };
}
