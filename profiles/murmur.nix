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
    sslCert = "/var/lib/acme/mumble.sludge.network/fullchain.pem";
    sslKey = "/var/lib/acme/mumble.sludge.network/key.pem";
    registerName = "Hidie Room";
    registerHostname = "murmur.sludge.network";
    logFile = "/var/log/murmur/murmurd.log";
  };

  # config.users.groups."mumble-sludge-network".members = ["murmur"];
  config.security.acme.certs."mumble.sludge.network" = {
    dnsProvider = "rfc2136";
    credentialsFile = "/var/glauca.env";
    reloadServices = ["murmur"];
  };
}
