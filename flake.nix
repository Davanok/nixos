{
  description = "Davanok NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self,
    nixpkgs, 
    home-manager,
    disko,
    ... 
  } @inputs: let
    globals = {
      system = "x86_64-linux";
      username = "davanok";
      hostname = "nixos";
    };
    
  in {
    nixosConfigurations.${globals.hostname} = nixpkgs.lib.nixosSystem {
      system = globals.system;
      specialArgs = { inherit inputs globals; };

      modules = [
        ./configuration.nix
        disko.nixosModules.disko
      ];
    };
  };
}
