{
  config,
  pkgs,
  ...
}: {
  config.services.murmur = {
    enable = true;
    openFirewall = true;
    password = "$MURMURD_PASSWORD";
    environmentFile = "/var/murmur.env";
    registerName = "Hidie Room";
    registerHostname = "murmur.sludge.network";
    logFile = "/var/log/murmur/murmurd.log";
  };
}
