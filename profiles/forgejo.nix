{
  pkgs,
  config,
  ...
}: {
  services.nginx.virtualHosts."git.sludge.network" = {
    forceSSL = true;
    enableACME = true;

    extraConfig = ''
      client_max_body_size 2048M;
    '';

    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}";
    };
  };

  services.forgejo = {
    enable = true;
    database.type = "postgres";
    lfs.enable = true;

    settings = {
      mailer = {
        ENABLED = true;
        SMTP_ADDR = "mail.sludge.network";
        SMTP_PORT = "465";
        FROM = "no-reply@sludge.network";
        USER = "no-reply@sludge.network";
        ENABLE_HELO = false;
      };
      service = {
        REGISTER_EMAIL_CONFIRM = true;
      };
      federation = {
        ENABLED = true;
      };
      actions = {
        ENABLED = true;
      };
      service.DISABLE_REGISTRATION = true;
      server = {
        ROOT_URL = "https://git.sludge.network/"; 
        DOMAIN = "git.sludge.network";
      };
    };

    secrets = {
      mailer = {
        PASSWD = "/var/forgejo/mail";
      };
    };
  };

  networking.firewall.allowedUDPPorts = [ 35943 35705 ];
  networking.firewall.allowedTCPPorts = [ 35943 35705 ];
}
