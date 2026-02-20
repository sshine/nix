# FIXME(sshine): Remove this file once all of the services below can be enabled with options
{ ... }:
{
  imports = [
    ./services/nginx.nix
    ./services/tailscale-vpn.nix
    ./services/registry.nix
    # ./services/prometheus.nix
    # ./services/vaultwarden.nix
    # ./services/radicle.nix
    # ./services/grafana.nix
    # ./services/axum-forum.nix
    # ./services/gitea.nix
    # ./services/loki.nix
  ];
}
