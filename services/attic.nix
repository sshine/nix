{ pkgs, lib, config, ... }:
{
  config = lib.mkIf config.services.atticd.enable {
    # Nix binary cache (Attic)
    # After initial setup, create /var/secrets/atticd.env with:
    #   ATTIC_SERVER_TOKEN_RS256_SECRET_BASE64="$(openssl genrsa -traditional 4096 | base64 -w0)"
    #   AWS_ACCESS_KEY_ID="<from garage key create attic-key>"
    #   AWS_SECRET_ACCESS_KEY="<from garage key info attic-key>"
    # Then: chmod 600 /var/secrets/atticd.env && chown atticd:atticd /var/secrets/atticd.env
    # And: garage bucket create attic && garage bucket allow attic --read --write --key attic-key
    services.atticd = {
      enable = true;
      environmentFile = "/var/secrets/atticd.env";
      settings = {
        listen = "[::]:8080";

        database.url = "sqlite:///var/lib/atticd/server.db?mode=rwc";

        storage = {
          type = "s3";
          bucket = "attic";
          region = "garage";
          endpoint = "http://127.0.0.1:3900";
        };

        compression = {
          type = "zstd";
        };

        chunking = {
          nar-size-threshold = 65536;
          min-size = 16384;
          avg-size = 65536;
          max-size = 262144;
        };
      };
    };

    # S3-compatible object storage (Garage)
    services.garage = {
      enable = true;
      settings = {
        metadata_dir = "/var/lib/garage/meta";
        data_dir = [
          {
            path = "/var/lib/garage/data";
            capacity = "100G";
          }
        ];
        replication_mode = "none";

        rpc_bind_addr = "[::]:3901";
        rpc_public_addr = "127.0.0.1:3901";

        s3_api = {
          s3_region = "garage";
          api_bind_addr = "[::]:3900";
          root_domain = ".s3.garage.localhost";
        };
      };
    };


  };
}
