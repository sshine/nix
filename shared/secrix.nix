{ pkgs, lib, config, secrix, ... }: {
  options = {
  };

  imports = [
    secrix.nixosModules.default
  ];
}
