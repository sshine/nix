{ pkgs, lib, config, home-manager ? null, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;
  home-manager.users.${config.users.superUser} = {...}: {
    home.username = config.users.superUser;
    home.homeDirectory = "/home/" + config.users.superUser;
    home.stateVersion = "24.05";

    # Prevent user-level "config missing" message.
    home.file.".zshrc".text = "# Intentionally left blank.";
  };
}
