{lib, ...}: {
  services.openssh = {
    enable = true;
    settings = {
      passwordAuthentication = false;
      permitRootLogin = "prohibit-password";
    };
  };
}
