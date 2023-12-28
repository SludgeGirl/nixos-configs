{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    deploy-rs.url = "github:serokell/deploy-rs";
    tree-input.url = "github:kittywitch/tree";
    sludge-site.url = "git+ssh://git@github.com/SludgeGirl/Site";
    tree-input.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    deploy-rs,
    tree-input,
    ...
  } @ inputs: let
    defaultModules = [
      home-manager.nixosModules.home-manager
    ];
    defaultSpecialArgs = {
      tree = metaTree.impure;
      pureTree = metaTree.pure;
      inherit inputs;
    };
    activateNixOS_x64_64-linux = deploy-rs.lib.x86_64-linux.activate.nixos;

    mkTree = inputs.tree-input.tree;
    metaTree = mkTree ((import ./treeConfig.nix {}) // {inherit inputs;});
  in rec {
    legacyPackages."x86_64-linux".mossball =
      nixosConfigurations.mossball.config.system.build.toplevel;

    nixosConfigurations.mossball = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = defaultSpecialArgs;
      modules = defaultModules ++ [./hosts/mossball];
    };

    deploy = {
      nodes = {
        mossball = {
          hostname = "94.130.48.76";
          profiles.system = {
            user = "root";
            sshUser = "root";
            path = activateNixOS_x64_64-linux nixosConfigurations.mossball;
            remoteBuild = true;
          };
        };
      };
    };
  };
}
