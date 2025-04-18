{ ... }: {
  imports = [
    ./machines/dao-hardware.nix
    ./machines/dao-networking.nix
    ./common.nix
  ];

  networking.hostName = "dao";
  networking.domain = "mechanicus.xyz";
  system.stateVersion = "23.11";
}
