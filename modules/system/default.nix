{ ... }:

{
  imports = [
    ./core/default.nix
    ./packages/default.nix
    ./services/default.nix
    ./programs.nix
    ./shell.nix
    ./user.nix
  ];
}
