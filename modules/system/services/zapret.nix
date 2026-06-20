{ inputs, pkgs, ... }:

{
  imports = [
    inputs.zapret-discord-youtube.nixosModules.withTestTools
  ];

  services.zapret-discord-youtube = {
    enable = true;
    config = "general(ALT9)";  # Или другая стратегия
    gameFilter = "null";
  };

  environment.systemPackages = [ pkgs.cloudflare-warp ];
  services.cloudflare-warp.enable = true;
}