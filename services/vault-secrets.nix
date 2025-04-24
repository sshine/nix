{ pkgs, lib, config, vault-secrets, ... }: {
  options = {
    services.vault-secrets.enable = lib.mkEnableOption "vault-secrets";
  };

  imports = [
    vault-secrets.nixosModules.vault-secrets
  ];

  config = lib.mkIf config.services.vault-secrets.enable {
    config.allowUnfree = true;
    nixpkgs.overlays = [
      vault-secrets.overlays.default
    ];
  };
}
