{ ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 222 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "yes";
    };
  };
}
