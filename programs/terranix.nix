{ pkgs, lib, config }:
{
  options = {
    programs.terranix.enable = lib.mkEnableOption "terranix";
    programs.terranix.package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.opentofu;
      example = "pkgs.terraform";
      description = "The package to use for Terraform/OpenTofu functionality.";
    };
  };

  config = lib.mkIf config.programs.terranix.enable
    {
      environment.systemPackages = [
        pkgs.terranix
        config.programs.terranix.package
      ];
    };
}
