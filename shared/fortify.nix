{ pkgs, lib, config, fortify, ... }: {
  options = {
  };


  config = {
    modules = [
      fortify.nixosModules.fortify
    ];

    config.environment.fortify = {
      enable = true;
    };
  };
}
