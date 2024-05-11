{
  config,
  pkgs,
  inputs,
  ...
}: {
  services.nginx.virtualHosts."sludge.network" = {
    root = "${inputs.sludge-site.defaultPackage.${pkgs.system}}";
    forceSSL = true;
    useACMEHost = "sludge.network";
  };
}
