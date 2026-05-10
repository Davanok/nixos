{
  description = "Davanok NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self,
    nixpkgs, 
    home-manager, 
    nur, 
    ... 
  } @inputs: let
    system = "x86_64-linux";
    globals = {
      username = "davanok";
      hostname = "nixos";
    };
    
  in {
    nixosConfigurations.${globals.hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs globals; };

      modules = [
        ./configuration.nix
        nur.modules.nixos.default
      ];
    };
  };
}
