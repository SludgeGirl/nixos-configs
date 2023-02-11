{
  config,
  pkgs,
  ...
}: {
  users.users.pixelmon = {
    isNormalUser = true;
    group = "pixelmon";
  };
  users.groups.pixelmon = {};

  environment.systemPackages = [pkgs.screen pkgs.jdk11];
  systemd.services.pixelmon = {
    enable = false;
    description = "Runs the pixelmon server";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    unitConfig = {
      After = "network.target";
      StartLimitIntervalSec = "5";
    };
    serviceConfig = {
      Type = "simple";
      User = "pixelmon";
      Restart = "always";
      RemainAfterExit = "yes";
      WorkingDirectory = "/srv/pixelmon/";
      ExecStart = ''${pkgs.screen}/bin/screen -Logfile /srv/pixelmon/logs/screen.log -dmS pixelmon ${pkgs.jdk11}/bin/java -Xmx4096M -jar /srv/pixelmon/forge-1.16.5-36.2.34.jar'';
    };
  };

  services.postfix.domain = "mail.sludge.network";
  services.postfix.origin = "mail.sludge.network";

  networking.firewall = {
    allowedUDPPorts = [25565];
    allowedTCPPorts = [25565];
  };
}
