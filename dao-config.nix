{ ... }: {
  imports = [
    ./machines/dao-hardware.nix
    ./machines/dao-networking.nix
    ./common.nix
    ./users.nix
    ./home-manager.nix
  ];

  networking.hostName = "dao";
  networking.domain = "mechanicus.xyz";
  system.stateVersion = "23.11";
}
