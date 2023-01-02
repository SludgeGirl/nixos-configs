{
  config,
  pkgs,
  ...
}: {
  users.users.sludge = {
    uid = 1000;
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "disk"
      "systemd-journal"
      "input"
      "uinput"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEdwOxk6/VaBO+X/DCggz5r0IR8Zp/3k2aQEtt3Oq9L7 sludge@wonderland"
    ];
  };
}
