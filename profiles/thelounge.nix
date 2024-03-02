{
  config,
  pkgs,
  ...
}: {
  services.thelounge = {
    enable = true;
    public = false;

    extraConfig = {
      prefetch = true;
      host = "127.0.0.1";
      prefetchMaxImageSize = 8192;
    };
  };

  services.nginx.virtualHosts."irc.sludge.network" = {
    forceSSL = true;
    enableACME = true;

    locations."/" = {
      proxyPass = "http://127.0.0.1:9000";
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
