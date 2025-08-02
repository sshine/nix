# FIXME(sshine): Remove this file once all of the services below can be enabled with options
{ ... }:
{
  imports = [
    ./services/nginx.nix
    ./services/tailscale-vpn.nix
    ./services/grafana.nix
    ./services/prometheus.nix
    ./services/radicle.nix
    ./services/vaultwarden.nix
    # ./services/axum-forum.nix
    # ./services/gitea.nix
    # ./services/loki.nix
  ];
}
