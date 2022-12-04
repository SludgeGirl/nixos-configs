# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix 
    ./zfs.nix
    ../../profiles/base

    ../../users/sludge.nix

    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  # Define on which hard drive you want to install Grub.

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.

  # Configure keymap in X11
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     thunderbird
  #   ];
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Allow ssh key
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDYG9DW+A7mec59SdhQgBD5DwJJgBuL1lQPf3kaHRztPMxZB957Uim5Z2WrBLDJnAdsYTr5xa0tiy4luwHukYx0At57KsGGHjcqsmEUi6anmtGnJ6XJtU1F4qdhgxgx890qdoufByu8H/n+oYHfMBFHQW38ldDRTzB9dxbTq5qqryO4SqQVAl0eEVder2JTTWRT+0DzAzkvXj3V01H5lNFIqTqlcnSk9ZJ20j92dA/H4pvYM89psx4iOjgwg9tqFvkduIFY8FjT7Zn1+qgnergvFC3ik6kh4mLmyoLX0+WpxTPJaGiZ48f8z0iRdvNXKq7gr7F1t170ojebBgagojinhjsMpdJTnoDqRm589q1UY56xoXDZoZYTzZ6HIMaz0uBQqDXjXFLoMDsiK9FgrmE0LIhEWbqXaHlIH4YebL+OPpjLOVLuAmKAN8Q71JoWlZlskhSxh2e6nlutz/sW0+pqMl6R4uljYD1ebGUdQAsqPRkcXDfcgODLjMI2xepCi2E= sludge@pop-os"
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    extraOptions =
      lib.optionalString
      (lib.versionAtLeast config.nix.package.version "2.4") ''
        experimental-features = nix-command flakes
      '';
    settings.trusted-users = ["root" "@wheel"];
  };
}

