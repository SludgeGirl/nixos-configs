{
  networking = {
    useDHCP = false;
    usePredictableInterfaceNames = true;
    interfaces.eth0 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          # WARNING: MAIN IP DO NOT TOUCH
          address = "94.130.48.76";
          prefixLength = 26;
        }
      ];
      ipv6.addresses = [
        {
          # WARNING: MAIN IP DO NOT TOUCH
          address = "2a01:4f8:10b:25e0::1";
          prefixLength = 64;
        }
        {
          address = "fe80::921b:eff:febd:9b39";
          prefixLength = 64;
        }
      ];
      ipv4.routes = [
        {
          address = "94.130.48.64";
          prefixLength = 26;
        }
      ];
      ipv6.routes = [
        {
          address = "fe80::1";
          prefixLength = 128;
        }
      ];
    };

    defaultGateway6 = {
      address = "fe80::1";
      interface = "eth0";
    };

    defaultGateway = "94.130.48.65";
    nameservers = ["8.8.8.8" "8.8.4.4"];
  };
}
