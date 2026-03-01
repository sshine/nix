{ pkgs, lib, config, claudebox, ... }: {
  options = {
    programs.claude-code.enable = lib.mkEnableOption "claude-code";
  };

  config = lib.mkIf config.programs.claude-code.enable
    {
      environment.systemPackages = [
        pkgs.claude-code
        claudebox.packages.${pkgs.system}.default
      ];
    };
}
