{
  config,
  pkgs,
  ...
}: {
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    autoUpdateApps.enable = true;
    hostName = "nextcloud.sludge.network";

    https = true;

    extraAppsEnable = true;
    extraApps = with pkgs.nextcloud30Packages.apps; {
      inherit deck;
    };
    settings = {
      overwriteProtocol = "https";
      defaultPhoneRegion = "GB";
    };

    maxUploadSize = "2G";

    config = {
      adminpassFile = "/var/nextcloud/admin-pass";
      adminuser = "sludge";

      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
    };
  };

  services.postgresql = {
    ensureDatabases = ["nextcloud"];
    ensureUsers = [
      {
        name = "nextcloud";
        ensureDBOwnership = true;
      }
    ];
  };

  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };

  services.nginx.virtualHosts."nextcloud.sludge.network" = {
    forceSSL = true;
    useACMEHost = "sludge.network";
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
