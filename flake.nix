{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    deploy-rs,
    ...
  } @ inputs: let
    defaultModules = [
      home-manager.nixosModules.home-manager
    ];
    activateNixOS_x64_64-linux = deploy-rs.lib.x86_64-linux.activate.nixos;
  in rec {
    legacyPackages."x86_64-linux".mossball =
      nixosConfigurations.mossball.config.system.build.toplevel;

    nixosConfigurations.mossball = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = defaultModules ++ [./hosts/mossball];
    };

    deploy.nodes = {
      mossball = {
        hostname = "94.130.48.76";
        profiles.system = {
          user = "root";
          sshUser = "root";
          path = activateNixOS_x64_64-linux nixosConfigurations.mossball;
        };
      };
    };
  };
}
