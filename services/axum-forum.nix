{ pkgs, axum-forum, ... }: {
  imports = [
    axum-forum.nixosModules.default
  ];

  services.axum-forum = {
    enable = true;
    # user = "sshine";
    # group = "users";
    # dataDir = "/home/sshine/tmp-data";
  };

  #services.nginx = {
  #  enable = true;
  #  recommendedGzipSettings = true;
  #  recommendedOptimisation = true;
  #  recommendedProxySettings = true;
  #  recommendedTlsSettings = true;
  #
  #  virtualHosts.
  #};
}
