{...}: {
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDKGc/5Ob0s5PQfs6bHYozP3/xMqyLVtW3imo5iRCAA9"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXakbTs0Cy7F+OLMtfGT1jCKK+xkM1phdFuYq4PfUNw sludge@vermillion"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILbw+AVDQKQn8qiYNFgzN1CNHNnv4fnmZmbeXbk7a013 sludge@apothecium"
    ];
  };
}
