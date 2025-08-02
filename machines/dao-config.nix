{ ... }: {
  imports = [
    ../common.nix
    ./dao-networking.nix
    ./hetzner-vps-hardware.nix
  ];

  networking.hostName = "dao";
  networking.domain = "mechanicus.xyz";
  system.stateVersion = "23.11";

  programs.irssi.enable = true;
  programs.terranix.enable = true;
}
