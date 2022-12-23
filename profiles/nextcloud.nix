{config, pkgs, ...}:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud25;
    enableBrokenCiphersForSSE = false;
    autoUpdateApps.enable = true;

    https = true;

    extraAppsEnable = true;
    extraApps = with pkgs.nextcloud25Packages.apps; {
      inherit twofactor_webauthn mail;
    };

    config = {
      overwriteProtocol = "https";

      adminpassFile = "${pkgs.writeText "adminpass" "5rR%FowfE8cmZ2NCdKkYADeiRnqTm@fXjAsQRXUgiGL4xU&C@%"}";
      adminuser = "sludge";
      objectstore.s3 = {
        enable = true;
        autocreate = true;
        bucket = "sludge";
        hostname = "fra1.digitaloceanspaces.com";
        region = "fra1";
        port = 443;
        key = "DO00AH9QKRELVLMBF6R3";
        secretFile = "/var/nextcloud-objectstore-digitalocean-secret";
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "admin@sludge.network";
  };

  services.nginx.virtualHosts."nextcloud.sludge.network" = {
    forceSSL = true;
    enableACME = true;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}