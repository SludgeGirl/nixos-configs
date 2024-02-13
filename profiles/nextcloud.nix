{
  config,
  pkgs,
  ...
}: {
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud28;
    autoUpdateApps.enable = true;
    hostName = "nextcloud.sludge.network";

    https = true;

    extraAppsEnable = true;
    extraApps = with pkgs.nextcloud25Packages.apps; {
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
      objectstore.s3 = {
        enable = true;
        autocreate = true;
        bucket = "sludge";
        hostname = "fra1.digitaloceanspaces.com";
        region = "fra1";
        port = 443;
        key = "DO00AH9QKRELVLMBF6R3";
        secretFile = "/var/nextcloud/objectstore-digitalocean-secret";
      };

      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
    };
  };

  services.postgresql = {
    enable = true;
    initialScript = pkgs.writeText "initscript" ''
      CREATE ROLE nextcloud WITH LOGIN PASSWORD 'nextcloud' CREATEDB;
      CREATE DATABASE nextcloud;
      GRANT ALL PRIVILEGES ON DATABASE nextcloud TO nextcloud;
    '';
  };

  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "admin@sludge.network";
  };

  services.nginx.virtualHosts."nextcloud.sludge.network" = {
    forceSSL = true;
    enableACME = true;
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
