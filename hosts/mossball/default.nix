# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  tree,
  ...
}: {
  imports = with tree; [
    profiles.base
    profiles.sshd

    users.sludge
    users.root

    ./hardware-configuration.nix
    ./zfs.nix
  ];

  environment.systemPackages = with pkgs; [
    vim
  ];

  users.users.root.initialHashedPassword = "$6$9Uzf03z9g.tel3dL$wj0l0gPjd0ptWhKf4UheFndgEbArfEZtXqsqDstOMnY/GNJZjHFb5LzXkIaUD6AcR.KU.bwR1.usOzQDh95nc/";
  system.stateVersion = "22.05";
}
