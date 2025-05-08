{ ... }:
let
  mkStaticSite = domain: {
    forceSSL = true;
    enableACME = true;
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
      ];
      locations."/" = {
        return = "444";
      };
    };

    virtualHosts."nix.tools" = mkStaticSite "nix.tools";
    virtualHosts."gordian.systems" = mkStaticSite "gordian.systems";
    virtualHosts."simonshine.dk" = mkStaticSite "simonshine.dk";
    virtualHosts."datamatik.blog" = mkStaticSite "datamatik.blog";
    virtualHosts."shine-translation.dk" = mkStaticSite "shine-translation.dk";
    virtualHosts."mechanicus.xyz" = mkStaticSite "mechanicus.xyz" // {
      locations."/" = {
        proxyPass = "http://127.0.0.1:3010";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };
}
