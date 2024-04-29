# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  tree,
  inputs,
  lib,
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
  networking.firewall.enable = true;

  users.users.root.initialHashedPassword = "$6$9Uzf03z9g.tel3dL$wj0l0gPjd0ptWhKf4UheFndgEbArfEZtXqsqDstOMnY/GNJZjHFb5LzXkIaUD6AcR.KU.bwR1.usOzQDh95nc/";
  system.stateVersion = "22.05";

  services.nextcloud.hostName = "nextcloud.sludge.network";
  services.timesyncd.enable = true;

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  services.clamav.daemon.enable = true;
  services.clamav.scanner.enable = true;
  services.clamav.updater.enable = true;

  # Run the scanner every half hour
  services.clamav.scanner.interval = "*-*-* *:00,30:00";
  # Move and do something with the detected virus
  # The defaults just detect it
  systemd.services.clamdscan.serviceConfig.ExecStart = lib.mkForce "${pkgs.clamav}/bin/clamdscan --move=/root/found_viruses/ --multiscan --fdpass --infected --allmatch ${lib.concatStringsSep " " config.services.clamav.scanner.scanDirectories}";
}
