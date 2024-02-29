{
  config,
  pkgs,
  ...
}: {
  services.nginx.virtualHosts."slides.sludge.network" = {
    enableACME = true;
    forceSSL = true;

    locations."/" = {
      proxyPass = "http://localhost:4000";

      extraConfig = "proxy_ssl_server_name on;";
    };
  };
  virtualisation.oci-containers.backend = "podman";

  virtualisation.oci-containers.containers = {
    git-talk = {
      image = "alectair/git-talk";
      autoStart = true;
      ports = ["4000:4000"];
      extraOptions = ["--pull=always"];
    };
  };
}
