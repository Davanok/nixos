{ ... }:

{
  imports = [
    ./core/default.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./shell.nix
    ./user.nix
  ];
}
