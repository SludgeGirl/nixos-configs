{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  nix = {
    package = pkgs.nixVersions.git;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.trusted-users = ["root" "@wheel"];
  };
  nixpkgs = {
    config = {allowUnfree = true;};
    #overlays = [(import ../../overlay)];
  };
}
