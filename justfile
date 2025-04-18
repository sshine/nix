
# List all just commands
list:
  just --list

switch:
  sudo nixos-rebuild switch --flake .#`uname -n`

gc:
  sudo nix-collect-garbage -d

# Create a dummy SSL certificate for default nginx virtualhost
dummy-ssl:
  sudo mkdir -p /etc/ssl/private
  sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/dummy.key \
    -out /etc/ssl/certs/dummy.crt \
    -subj "/CN=unused"
