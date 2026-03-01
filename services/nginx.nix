{ config, lib, ... }:
let
  robotsTxtLocation = {
    "=/robots.txt" = {
      extraConfig = ''
        default_type text/plain;
        return 200 "User-Agent: *\nAllow: /\n";
      '';
    };
  };

  mkStaticSite = domain: {
    forceSSL = true;
    enableACME = true;
    root = "/var/www/${domain}/public";
    locations = robotsTxtLocation;
    extraConfig = ''
      access_log /var/log/nginx/${domain}.access.log;
      error_log /var/log/nginx/${domain}.error.log;
    '';
  };

  mkRedirectSite = dest: {
    forceSSL = true;
    enableACME = true;
    locations = robotsTxtLocation // {
      "/" = {
        extraConfig = ''
          return 301 ${dest};
        '';
      };
    };
  };

  mkProxiedSite = host: port: {
    forceSSL = true;
    enableACME = true;
    locations = robotsTxtLocation // {
      "/" = {
        proxyPass = "http://${host}:${toString port}";
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
in
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "simon@gordian.systems";
  };

  services.nginx.appendHttpConfig = ''
    proxy_headers_hash_max_size 1024;
    proxy_headers_hash_bucket_size 128;
  '';

  services.nginx.serverNamesHashBucketSize = 128;

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

    # Static sites
    virtualHosts."gordian.systems" = mkStaticSite "gordian.systems";
    virtualHosts."simonshine.dk" = mkStaticSite "simonshine.dk";
    virtualHosts."datamatik.blog" = mkRedirectSite "https://simonshine.dk/tags/datamatik";
    virtualHosts."nix.tools" = mkRedirectSite "https://simonshine.dk/tags/nix";
    virtualHosts."shine-translation.dk" = mkStaticSite "shine-translation.dk";
    virtualHosts."mechanicus.xyz" = mkStaticSite "mechanicus.xyz";
    virtualHosts."droids.agency" = mkStaticSite "droids.agency";

    # Apps
    # virtualHosts."mechanicus.xyz" = mkProxiedSite "mechanicus.xyz" config.services.radicle.httpd.listenPort;
    # virtualHosts."vault.mechanicus.xyz" = mkProxiedSite "vault.mechanicus.xyz" config.services.vaultwarden.config.ROCKET_PORT;

    virtualHosts."s3.${config.networking.domain}" = lib.mkIf config.services.garage.enable (lib.mkMerge [
      (mkProxiedSite "127.0.0.1" 3900)
      {
        extraConfig = ''
          client_max_body_size 0;
        '';
      }
    ]);

    virtualHosts."cache.${config.networking.domain}" = lib.mkIf config.services.atticd.enable (lib.mkMerge [
      (mkProxiedSite "127.0.0.1" 8080)
      {
        extraConfig = ''
          client_max_body_size 0;
        '';
      }
    ]);
  };
}
