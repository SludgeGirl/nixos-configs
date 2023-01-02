{pkgs, ...}: {
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    shellAliases = {
      la = "ls -lah";
    };

    ohMyZsh = {
      enable = true;
      plugins = [];
      theme = "gentoo";
    };
  };
}
