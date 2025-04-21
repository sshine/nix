{ pkgs, lib, config, ... }: {
  options = {
    programs.terranix.enable = lib.mkEnableOption "terranix";
  };

  config = lib.mkIf config.programs.terranix.enable
    {
      environment.systemPackages = [
        pkgs.terraform
        pkgs.terranix
      ];
    };
}
