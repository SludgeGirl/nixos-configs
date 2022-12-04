{
  config,
  pkgs,
  ...
}: {
  networking.hostId = "6327d770"; # HostID for ZFS
  boot.supportedFilesystems = ["zfs"];
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  boot.loader = {
    efi = {
      efiSysMountPoint = "/boot/efi";
      canTouchEfiVariables = false;
    };
    generationsDir.copyKernels = true;
    grub = {
      enable = true;
      version = 2;
      copyKernels = true;
      efiSupport = true;
      zfsSupport = true;
      efiInstallAsRemovable = true;
      extraPrepareConfig = ''
        mkdir -p /boot/efis
        for i in  /boot/efis/*; do mount $i ; done

        mkdir -p /boot/efi
        mount /boot/efi
      '';
      extraInstallCommands = ''
        ESP_MIRROR=$(mktemp -d)
        cp -r /boot/efi/EFI $ESP_MIRROR
        for i in /boot/efis/*; do
         cp -r $ESP_MIRROR/EFI $i
        done
        rm -rf $ESP_MIRROR
      '';
      devices = [
        "/dev/disk/by-id/nvme-SAMSUNG_MZVLB512HAJQ-00000_S3W8NA0M398290"
        "/dev/disk/by-id/nvme-SAMSUNG_MZVLB512HAJQ-00000_S3W8NA1M322792"
      ];
    };
  };
}
