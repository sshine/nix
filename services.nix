{ ... }:
{
  imports = [
    ./services/sshd.nix
    ./services/nginx.nix
    ./services/tailscale-vpn.nix
  ];
}
