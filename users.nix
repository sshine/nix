{ pkgs, lib, config, ... }: {
  options = {
    users.superUser = lib.mkDefault "sshine";
    users.sharedKeys = lib.mkDefault [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHa9kX7Px572nm5ULbdUiRzo8nwQMqDaAU9tBUXmhagQ''
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHK8UQNq6n9nPfxWt1RAPmKA+AfhHaKlTCS3bZ/HIg6H''
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAION/ZQUwQruxz7ero92SyO9s7Ck4pw3HPiutpWbcYO5p''
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2aLVgYzvZoWSCURE54JAP0f3oSiIoTNRullHoJYN6z''
    ];
  };

  config = {
    users.users.root.openssh.authorizedKeys.keys = config.users.sharedKeys;
    users.users.${config.users.superUser} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = config.users.sharedKeys;
    };
  };
}
