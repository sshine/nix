{ pkgs, lib, config, ... }: {
  options = {
    programs.irssi.enable = lib.mkEnableOption "irssi";
  };

  config = lib.mkIf config.programs.irssi.enable
    {
      environment.systemPackages = [
        pkgs.irssi
      ];
    };
}
