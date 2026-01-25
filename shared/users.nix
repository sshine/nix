{ lib, pkgs, config, ... }: {
  options = {
    users.superUser = lib.mkOption {
      type = lib.types.str;
      default = "sshine";
      description = "The primary super-user account";
    };

    users.sharedKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHa9kX7Px572nm5ULbdUiRzo8nwQMqDaAU9tBUXmhagQ''
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHK8UQNq6n9nPfxWt1RAPmKA+AfhHaKlTCS3bZ/HIg6H''
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAION/ZQUwQruxz7ero92SyO9s7Ck4pw3HPiutpWbcYO5p''
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2aLVgYzvZoWSCURE54JAP0f3oSiIoTNRullHoJYN6z''
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN+WHf94v0BWIlOlPZZVnlWUgx0+s4EgusbXdWRoLvYD''
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBJqN6vKRZfPx4QOkQoIsJ6vJbiclaU9opbYLdzzk7bY''
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFWF+CfMuGgMsnqz8QWcNpxdx5j63UT6Mh7WCqvTH6o5 sshine@m1''
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFUMtKxIrZdXFRBRjHhI5o/loiu6HG0Yb87Ots5FBQH2 sshine@derp15''
      ];
      description = "SSH public keys shared between root and primary super-user account";
    };
  };

  config = {
    users.defaultUserShell = pkgs.zsh;
    users.users.root.openssh.authorizedKeys.keys = config.users.sharedKeys;
    users.users.${config.users.superUser} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = config.users.sharedKeys;
    };
  };
}
