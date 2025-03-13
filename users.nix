{ pkgs, ... }: let
  keys = [
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2aLVgYzvZoWSCURE54JAP0f3oSiIoTNRullHoJYN6z sshine@zhen''
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICjsn8RBtdJzneALvXNwyrpFzb6GqzZnHRjjvMjXBzPW sshine@umag''
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINk9vVXS7EQYBFKKLQTRSEKpjsVvKKmYcuCZlPLzOqSa sshine@p330''
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAION/ZQUwQruxz7ero92SyO9s7Ck4pw3HPiutpWbcYO5p sshine@shark''
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBJqN6vKRZfPx4QOkQoIsJ6vJbiclaU9opbYLdzzk7bY sshine@m3''
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHa9kX7Px572nm5ULbdUiRzo8nwQMqDaAU9tBUXmhagQ sshine@feng''
  ];
in
{
  users.defaultUserShell = pkgs.zsh;

  users.users.root.openssh.authorizedKeys.keys = keys;

  users.users.sshine = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = keys;
    extraGroups = [ "wheel" ];
  };

  security.sudo = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };
}
