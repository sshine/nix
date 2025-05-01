{
  description = "sshine's VPS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    secrix.url = "github:Platonic-Systems/secrix";
    secrix.inputs.nixpkgs.follows = "nixpkgs";

    # fortify.url = "git+https://git.gensokyo.uk/security/fortify";
    # fortify.inputs.nixpkgs.follows = "nixpkgs";
    # fortify.inputs.home-manager.follows = "home-manager";

    # vault-secrets = "github:serokell/vault-secrets";
    # vault-secrets.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.dao = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = inputs;
      modules = [ ./machines/dao-config.nix ];
    };

    apps.x86_64-linux.secrix = inputs.secrix.secrix self;
  };
}
