{
  config,
  pkgs,
  services,
  ...
}: {
  services.hedgedoc = {
    enable = true;
    settings = {
      port = 3300;
      domain = "notes.sludge.network";
      useSSL = false;
      protocolUseSSL = true;

      allowEmailRegister = false;
      allowAnonymous = false;
      defaultPermission = "private";

      db = {
        dialect = "postgres";
        host = "/run/postgresql";
        database = "hedgedoc";
      };
    };
  };

  services.nginx.virtualHosts."notes.sludge.network" = {
    forceSSL = true;
    useACMEHost = "sludge.network";
    locations."/".proxyPass = "http://localhost:3300";
    locations."/socket.io/" = {
      proxyPass = "http://localhost:3300";
      proxyWebsockets = true;
      extraConfig = "proxy_ssl_server_name on;";
    };
  };
}
