{...}:
let
	prometheus_port = 9001;
  node_exporter_port = 9002;
  nginx_exporter_port = 9003;
in
{
  services.prometheus = {
    enable = true;
    port = prometheus_port;
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = node_exporter_port;
      };

      nginx = {
        enable = true;
        port = nginx_exporter_port;
      };
    };

    scrapeConfigs = [
      {
        job_name = "chrysalis";
        static_configs = [{
          targets = [ "127.0.0.1:${toString node_exporter_port}" ];
        }];
      }

      {
        job_name = "nginx";
        static_configs = [{
          targets = [ "127.0.0.1:${toString nginx_exporter_port}" ];
        }];
      }

    ];
  };
}
