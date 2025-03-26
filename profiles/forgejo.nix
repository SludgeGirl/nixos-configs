{
  pkgs,
  config,
  ...
}: {
  services.nginx.virtualHosts."git.sludge.network" = {
    forceSSL = true;
    useACMEHost = "sludge.network";

    extraConfig = ''
      client_max_body_size 2048M;
    '';

    locations."/" = {
      proxyPass = "http://127.0.0.1:9800";
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
        DOMAIN = "localhost";
      };
      security = {
        REVERSE_PROXY_TRUSTED_PROXIES = "127.0.0.0/8,::1/128";
      };
    };

    secrets = {
      mailer = {
        PASSWD = "/var/forgejo/mail";
      };
    };
  };

  services.gitea-actions-runner = {
    package = pkgs.forgejo-actions-runner;
    instances.default = {
      enable = true;
      name = "monolith";
      url = "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}";
      # Obtaining the path to the runner token file may differ
      tokenFile = "/var/forgejo/runner";
      labels = [
        "ubuntu-latest:docker://node:18-bullseye"
        "debian-latest:docker://node:18-bullseye"
        "fedora-latest:docker://node:18-bullseye"
      ];
      settings = {
        container = {
          network = "host";
        };
      };
    };
  };

  virtualisation.oci-containers.containers.forgejo-anubis = {
    image = "ghcr.io/techarohq/anubis:latest";
    autoStart = true;
    extraOptions = ["--pull=always" "--network=host"];
    environment = {
      BIND = ":9800";
      TARGET = "http://localhost:${toString config.services.forgejo.settings.server.HTTP_PORT}";
    };
  };

  networking.firewall.allowedUDPPorts = [ 35943 35705 ];
  networking.firewall.allowedTCPPorts = [ 35943 35705 ];
}
