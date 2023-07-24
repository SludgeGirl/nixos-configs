{
  config,
  pkgs,
  inputs,
  ...
}: {
  services.nginx.virtualHosts."slides.sludge.network" = {
    locations."/git" = {
        proxyPass = "http://127.0.0.1:4000";
        forceSSL = true;
        enableACME = true;

        extraConfig =
            "proxy_ssl_server_name on;"
        ;
    };
  };

  systemd.services.git-talk = {
    enable = true;
    path = "${inputs.git-talk.defaultPackage.${pkgs.system}}";
    script = "${pkgs.npm} start"
  };
}
