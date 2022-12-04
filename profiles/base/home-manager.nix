{
  inputs,
  config,
  lib,
  ...
}:
with lib; {
  options.home-manager.users = mkOption {
    type = types.attrsOf (types.submoduleWith {
      modules = [];
      specialArgs = {
        inherit inputs;
        nixos = config;
      };
    });
  };
  config = {
    home-manager = {
      # so it uses overlays and current nixpkgs
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
