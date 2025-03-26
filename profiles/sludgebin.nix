{
  ...
}: {
  services.nginx.virtualHosts."bin.sludge.network" = {
    forceSSL = true;
    useACMEHost = "sludge.network";

    locations."/" = {
      proxyPass = "http://0.0.0.0:9802";

      extraConfig = "proxy_ssl_server_name on;";
    };
  };

  virtualisation.oci-containers.containers.sludgebin = {
    image = "git.sludge.network/sludge/sludgebin:latest";
    autoStart = true;
    ports = ["8033:8080"];
    extraOptions = ["--pull=always"];
  };

  virtualisation.oci-containers.containers.anubis-sludgebin = {
    image = "ghcr.io/techarohq/anubis:latest";
    autoStart = true;
    extraOptions = ["--pull=always" "--network=host"];
    environment = {
      BIND = ":9802";
      TARGET = "http://localhost:8033";
      METRICS_BIND = ":9803";
    };
  };
}
