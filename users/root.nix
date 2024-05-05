{...}: {
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEdwOxk6/VaBO+X/DCggz5r0IR8Zp/3k2aQEtt3Oq9L7 sludge@wonderland"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF0RS20VAsTHQ5Lm82saLBpf0qsmgQ/UnhF6sS5XlJTJ sludge@DESKTOP-3K6SU4J"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIjYQ9IGw3aWonTyNv2mAMd24fmBC3DjgQPbLPD9yTRY sludge@maidcafe"
    ];
  };
}
