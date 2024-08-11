{
  pkgs,
  config,
  ...
}: {
  services.nginx.virtualHosts."git.sludge.network" = {
    forceSSL = true;
    useACMEHost = "sludge.network";

    extraConfig = ''
      client_max_body_size 512M;
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
        FROM = "no-reply@sludge.network";
        USER = "no-reply@sludge.network";
      };
      service.DISABLE_REGISTRATION = true;
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      server = {
        ROOT_URL = "https://git.sludge.network/"; 
        DOMAIN = "git.sludge.network";
      };
    };
    mailerPasswordFile = "/var/forgejo/mail";
  };

  services.gitea-actions-runner = {
    package = pkgs.forgejo-actions-runner;
    instances.default = {
      enable = true;
      name = "monolith";
      url = "https://git.sludge.network";
      # Obtaining the path to the runner token file may differ
      tokenFile = "/var/forgejo/runner";
      labels = [
        "ubuntu-latest:docker://node:16-bullseye"
      ];
      settings = {
        container = {
          network = "bridge";
        };
      };
    };
  };

  networking.firewall.allowedUDPPorts = [ 35943 ];
  networking.firewall.allowedTCPPorts = [ 35943 ];
}
