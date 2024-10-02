{
  config,
  pkgs,
  ...
}: {
  imports = [
    (builtins.fetchTarball {
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/nixos-24.05/nixos-mailserver-nixos-24.05.tar.gz";
      sha256 = "0clvw4622mqzk1aqw1qn6shl9pai097q62mq1ibzscnjayhp278b";
    })
  ];

  mailserver = {
    enable = true;
    fqdn = "mail.sludge.network";
    domains = ["sludge.network"];

    #certificateDomains = ["imap.sludge.network" "smtp.sludge.network"];

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

    enableManageSieve = true;

    mailboxes = {
      Drafts = {
        auto = "subscribe";
        specialUse = "Drafts";
      };
      Junk = {
        auto = "subscribe";
        specialUse = "Junk";
      };
      Sent = {
        auto = "subscribe";
        specialUse = "Sent";
      };
      Trash = {
        auto = "no";
        specialUse = "Trash";
      };
    };

    certificateScheme = "acme-nginx";
  };
}
