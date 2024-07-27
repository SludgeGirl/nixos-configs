{...}: {
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEdwOxk6/VaBO+X/DCggz5r0IR8Zp/3k2aQEtt3Oq9L7 sludge@wonderland"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIjYQ9IGw3aWonTyNv2mAMd24fmBC3DjgQPbLPD9yTRY sludge@maidcafe"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDKGc/5Ob0s5PQfs6bHYozP3/xMqyLVtW3imo5iRCAA9"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXakbTs0Cy7F+OLMtfGT1jCKK+xkM1phdFuYq4PfUNw sludge@vermillion"
    ];
  };
}
