list:
  just --list

switch:
  sudo nixos-rebuild switch --flake .#`uname -n`

gc:
  sudo nix-collect-garbage -d
