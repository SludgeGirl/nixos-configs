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
      reverseProxy = true;

      fileUpload = {
        enable = true;
      };
    };
  };

  services.nginx.virtualHosts."irc.sludge.network" = {
    forceSSL = true;
    useACMEHost = "sludge.network";

    locations."/" = {
      proxyPass = "http://127.0.0.1:9000";
    };
  };

  systemd.services.thelounge-file-cleanup = {
    description = "Cleanup thelounge uploads";
    requires = ["multi-user.target"];
    after = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      SuccessExitStatus = "0";
      ExecStart = "find /var/lib/thelounge/uploads/ -type f -mtime +7 -print -delete";
    };
  };

  systemd.timers.thelounge-file-cleanup = {
    description = "Time for cleaning up thelounge file uploads";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "*-*-* 09:00:00";
      Unit = "thelounge-file-cleanup.service";
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
