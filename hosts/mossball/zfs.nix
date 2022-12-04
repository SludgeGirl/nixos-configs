{ config, pkgs, ... }:

{ boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "6327d770";
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
boot.loader.efi.efiSysMountPoint = "/boot/efi";
boot.loader.efi.canTouchEfiVariables = false;
boot.loader.generationsDir.copyKernels = true;
boot.loader.grub.efiInstallAsRemovable = true;
boot.loader.grub.enable = true;
boot.loader.grub.version = 2;
boot.loader.grub.copyKernels = true;
boot.loader.grub.efiSupport = true;
boot.loader.grub.zfsSupport = true;
boot.loader.grub.extraPrepareConfig = ''
  mkdir -p /boot/efis
  for i in  /boot/efis/*; do mount $i ; done

  mkdir -p /boot/efi
  mount /boot/efi
'';
boot.loader.grub.extraInstallCommands = ''
ESP_MIRROR=$(mktemp -d)
cp -r /boot/efi/EFI $ESP_MIRROR
for i in /boot/efis/*; do
 cp -r $ESP_MIRROR/EFI $i
done
rm -rf $ESP_MIRROR
'';
boot.loader.grub.devices = [
      "/dev/disk/by-id/nvme-SAMSUNG_MZVLB512HAJQ-00000_S3W8NA0M398290"
      "/dev/disk/by-id/nvme-SAMSUNG_MZVLB512HAJQ-00000_S3W8NA1M322792"
    ];
users.users.root.initialHashedPassword = "$6$9Uzf03z9g.tel3dL$wj0l0gPjd0ptWhKf4UheFndgEbArfEZtXqsqDstOMnY/GNJZjHFb5LzXkIaUD6AcR.KU.bwR1.usOzQDh95nc/";
}
