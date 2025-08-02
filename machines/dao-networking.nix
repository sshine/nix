{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [
      "2a01:4ff:ff00::add:1"
      "2a01:4ff:ff00::add:2"
      "185.12.64.2"
    ];
    defaultGateway = "172.31.1.1";
    defaultGateway6 = {
      address = "fe80::1";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address = "195.201.3.232"; prefixLength = 32; }
        ];
        ipv6.addresses = [
          { address = "2a01:4f8:1c0c:718c::1"; prefixLength = 64; }
          { address = "fe80::9400:4ff:fe3b:2b00"; prefixLength = 64; }
        ];
        ipv4.routes = [{ address = "172.31.1.1"; prefixLength = 32; }];
        ipv6.routes = [{ address = "fe80::1"; prefixLength = 128; }];
      };
      enp7s0 = {
        ipv4.addresses = [
          { address = "10.1.1.5"; prefixLength = 32; }
        ];
        ipv6.addresses = [
          { address = "fe80::8400:ff:fec8:1b9f"; prefixLength = 64; }
        ];
      };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="96:00:04:3b:2b:00", NAME="eth0"
    ATTR{address}=="86:00:00:c8:1b:9f", NAME="enp7s0"
  '';
}
