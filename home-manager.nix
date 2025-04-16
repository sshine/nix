{ pkgs, home-manager, ... }: {
  imports = [
    home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.sshine = {...}: {
    home.username = "sshine";
    home.homeDirectory = "/home/sshine";
    home.stateVersion = "24.05";

    xdg.configFile."atuin/config.toml".source = ./dotfiles/atuin-config.toml;
  };
}
