{ pkgs, sops-nix, ... }: {
  imports = [
    sops-nix.nixosModules.sops
  ];
}
