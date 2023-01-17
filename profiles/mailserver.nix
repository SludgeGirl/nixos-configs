{
  config,
  pkgs,
  ...
}: {
  imports = [
    (builtins.fetchTarball {
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/f535d8123c4761b2ed8138f3d202ea710a334a1d/nixos-mailserver-f535d8123c4761b2ed8138f3d202ea710a334a1d.tar.gz";
      sha256 = "0csx2i8p7gbis0n5aqpm57z5f9cd8n9yabq04bg1h4mkfcf7mpl6";
    })
  ];

  mailserver = {
    enable = true;
    fqdn = "mail.sludge.network";
    domains = ["sludge.network"];

    certificateDomains = ["imap.sludge.network" "smtp.sludge.network" "sludge.network"];

    # A list of all login accounts. To create the password hashes, use
    # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
    loginAccounts = {
      "admin@sludge.network" = {
        hashedPasswordFile = "/var/mailaccounts/admin@sludge.network";
      };
      "me@sludge.network" = {
        hashedPasswordFile = "/var/mailaccounts/me@sludge.network";
      };
      "no-reply@sludge.network" = {
        hashedPasswordFile = "/var/mailaccounts/no-reply@sludge.network";
      };
    };

    certificateScheme = 3;
  };
}
