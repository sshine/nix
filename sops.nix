{ pkgs, sops-nix, ... }: {
  imports = [
    sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./secrets/default.yaml;
  };
}
