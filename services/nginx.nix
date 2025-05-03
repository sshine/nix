{ ... }:
let
  mkSite = enableSSL: domain: {
    forceSSL = enableSSL;
    enableACME = enableSSL;
    root = "/var/www/${domain}/public";
    extraConfig = ''
      access_log /var/log/nginx/${domain}.access.log;
      error_log /var/log/nginx/${domain}.error.log;
    '';
  };
in
{
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

    statusPage = true;

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

    virtualHosts."gordian.systems" = mkSite true "gordian.systems";
    virtualHosts."nix.tools" = mkSite true "nix.tools";
    virtualHosts."simonshine.dk" = mkSite true "simonshine.dk";
    virtualHosts."datamatik.blog" = mkSite true "datamatik.blog";
    virtualHosts."mechanicus.xyz" = mkSite true "mechanicus.xyz";
    virtualHosts."shine-translation.dk" = mkSite true "shine-translation.dk";
  };
}
