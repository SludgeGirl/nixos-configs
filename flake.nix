{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let 
    defaultModules = [
      home-manager.nixosModules.home-manager
    ];
  in {
    # so can nix build .#mossball for now
    nixosConfigurations.mossball = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = defaultModules ++ [ ./hosts/mossball ];
    };
  };
}
