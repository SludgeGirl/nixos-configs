{
  config,
  pkgs,
  ...
}: {
  virtualisation.oci-containers.containers = {
    gtnh = {
      image = "git.sludge.network/sludge/gtnh:latest";
      autoStart = true;
      ports = ["25565:25565"];
      volumes = [
        "/srv/gtnh:/srv"
      ];
      extraOptions = ["--pull=always"];
    };
  };
}
