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

  security.acme = {
    acceptTerms = true;
    defaults.email = "simon@gordian.systems";
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # TODO: Disable SSL on unknown domains by shutting down connection (444)
    virtualHosts."_" = {
      default = true;
      listen = [
        { addr = "0.0.0.0"; port = 80; }
        { addr = "[::]"; port = 80; }
        # { addr = "0.0.0.0"; port = 443; }
        # { addr = "[::]"; port = 443; }
      ];
      # sslCertificate = "/etc/ssl/certs/dummy.crt";
      # sslCertificateKey = "/etc/ssl/private/dummy.key";
      locations."/" = {
        return = "444";
      };
    };

    virtualHosts."gordian.systems" = {
      forceSSL = true;
      enableACME = true;
      root = "/var/www/gordian.systems/public";
    };

    virtualHosts."nix.tools" = {
      forceSSL = true;
      enableACME = true;
      root = "/var/www/nix.tools/public";
    };

    virtualHosts."simonshine.dk" = {
      forceSSL = true;
      enableACME = true;
      root = "/var/www/simonshine.dk/public";
    };

    virtualHosts."datamatik.blog" = {
      forceSSL = true;
      enableACME = true;
      root = "/var/www/datamatik.blog/public";

      # locations."/preview/" = {
      #   proxyPass = "http://127.0.0.1:1313";
      #   extraConfig = ''
      #     proxy_set_header Host $host;
      #     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      #   '';
      # };
    };

    virtualHosts."mechanicus.xyz" = {
      forceSSL = true;
      enableACME = true;
      root = "/var/www/mechanicus.xyz/public";
    };

    virtualHosts."shine-translation.dk" = {
      forceSSL = true;
      enableACME = true;
      root = "/var/www/shine-translation.dk/public";
    };

  };
}
