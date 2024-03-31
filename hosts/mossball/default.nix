# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  tree,
  inputs,
  ...
}: {
  imports = with tree; [
    profiles.base
    profiles.sshd
    profiles.podman
    profiles.pixelmon
    profiles.nextcloud
    # profiles.mailserver
    profiles.zsh
    profiles.murmur
    profiles.site
    profiles.znc
    profiles.thelounge
    profiles.hedgedoc

    users.sludge
    users.root

    ./hardware-configuration.nix
    ./zfs.nix
    ./networking.nix
  ];

  environment.systemPackages = with pkgs; [
    vim
    htop
    screen
    jdk11
    btop
    neofetch
  ];

  nixpkgs = {
    overlays = [
      inputs.sludge-site.overlay
    ];
  };

  networking.hostName = "mossball";

  users.users.root.initialHashedPassword = "$6$9Uzf03z9g.tel3dL$wj0l0gPjd0ptWhKf4UheFndgEbArfEZtXqsqDstOMnY/GNJZjHFb5LzXkIaUD6AcR.KU.bwR1.usOzQDh95nc/";
  system.stateVersion = "22.05";

  services.nextcloud.hostName = "nextcloud.sludge.network";
  services.timesyncd.enable = true;

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
}
