{
  config,
  pkgs,
  ...
}: {
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    autoUpdateApps.enable = true;
    hostName = "nextcloud.sludge.network";

    https = true;

    extraAppsEnable = true;
    extraApps = with pkgs.nextcloud29Packages.apps; {
      inherit;
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
    enable = true;
    package = pkgs.postgresql_14;

    ensureDatabases = ["hedgedoc" "nextcloud"];
    ensureUsers = [
      {
        name = "nextcloud";
        ensureDBOwnership = true;
      }
      {
        name = "hedgedoc";
        ensureDBOwnership = true;
      }
    ];
  };

  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "sludge-mossball@protonmail.com";
  };

  services.nginx.virtualHosts."nextcloud.sludge.network" = {
    forceSSL = true;
    enableACME = true;
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
