{
  config,
  pkgs,
  ...
}: {
  services.nginx.virtualHosts."bin.sludge.network" = {
    forceSSL = true;
    useACMEHost = "sludge.network";

    locations."/" = {
      proxyPass = "http://0.0.0.0:8033";

      extraConfig = "proxy_ssl_server_name on;";
    };
  };

  virtualisation.oci-containers.containers = {
    sludgebin = {
      image = "git.sludge.network/sludge/sludgebin:latest";
      autoStart = true;
      ports = ["8033:8080"];
      extraOptions = ["--pull=always"];
    };
  };
}
