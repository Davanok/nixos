{ pkgs, inputs, globals, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.${globals.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "dialout" ]; 
    shell = pkgs.fish; # Define default shell here directly
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs globals; };
    
    # Using default.nix is a standard Nix pattern for directory entry points
    users.${globals.username} = import ../home/default.nix; 
  };
}
