{
  config,
  pkgs,
  ...
}: {
  services.nginx.virtualHosts."gist.sludge.network" = {
    forceSSL = true;
    useACMEHost = "sludge.network";

    locations."/" = {
      proxyPass = "http://0.0.0.0:6157";

      extraConfig = "proxy_ssl_server_name on;";
    };
  };

  virtualisation.oci-containers.containers = {
    opengist = {
      image = "ghcr.io/thomiceli/opengist:1.7";
      autoStart = true;
      ports = ["6157:6157"];
      extraOptions = ["--pull=always"];
      environmentFiles = [
        "/var/opengist/secret"
      ];
      environment = {
        OG_GITEA_URL = "https://git.sludge.network";
      };
      volumes = [
        "/var/opengist:/opengist"
      ];
    };
  };
}
