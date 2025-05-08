{ ... }:
{
  imports = [
    ./services/sshd.nix
    ./services/nginx.nix
    ./services/tailscale-vpn.nix
    ./services/grafana.nix
    ./services/prometheus.nix
    ./services/radicle.nix
    # ./services/axum-forum.nix
    # ./services/gitea.nix
    # ./services/loki.nix
  ];
}
