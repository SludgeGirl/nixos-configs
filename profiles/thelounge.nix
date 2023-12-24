{
  config,
  pkgs,
  ...
}: {
  services.thelounge = {
    enable = true;
    public = false;
  };

  services.nginx.virtualHosts."irc.sludge.network" = {
    forceSSL = true;
    enableACME = true;

    locations."/" = {
      proxyPass = "http://localhost:9000";
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
