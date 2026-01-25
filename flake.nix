{
  description = "sshine's VPS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.flake-parts.follows = "flake-parts";

    birthday-rsvp.url = "git+ssh://git@github.com/sshine/birthday-rsvp.git";
    birthday-rsvp.inputs.nixpkgs.follows = "nixpkgs";

    # vault-secrets = "github:serokell/vault-secrets";
    # vault-secrets.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  {
    # webserver
    nixosConfigurations.feng = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = inputs;
      modules = [ ./machines/feng-config.nix ];
    };

    # gateway server
    nixosConfigurations.dao = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = inputs;
      modules = [ ./machines/dao-config.nix ];
    };

    nixosModules = {
      zsh = ./programs/zsh.nix;
      vim = ./programs/vim.nix;
    };

    darwinModules = {
      zsh = ./programs/zsh.nix;
      vim = ./programs/vim.nix;
    };
  };
}
