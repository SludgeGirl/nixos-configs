{lib, ...}: {
  services.znc = {
    enable = true;
    mutable = false; # Overwrite configuration set by ZNC from the web and chat interfaces.
    useLegacyConfig = false; # Turn off services.znc.confOptions and their defaults.
    openFirewall = true; # ZNC uses TCP port 5000 by default.
    config = {
      User.sludge = {
        Admin = true;
        Pass.password = {
          Method = "sha256"; # Fill out this section
          Hash = "cbce5f19c9b00431f699fd7b4c9022feab3f13b61a93424a13ae85b22e4b4fea"; # with the generated hash.
          Salt = "HI9j.Ns2gZatPw+)caoF";
        };
      };
    };
  };
}
