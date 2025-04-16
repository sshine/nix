{...}:
let
	prometheus_port = 9001;
  exporter_port = 9002;
in
{
  services.prometheus = {
    enable = true;
    port = prometheus_port;
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = exporter_port;
      };
    };

    scrapeConfigs = [
      {
        job_name = "chrysalis";
        static_configs = [{
          targets = [ "127.0.0.1:${toString exporter_port}" ];
        }];
      }
    ];
  };
}
