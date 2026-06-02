{ pkgs, inputs, globals, ... }:

{
  programs = {
    nix-ld.enable = true;

    fish.enable = true;

    localsend.enable = true;

    niri.enable = true;

    dms-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      enableVPN = true;
    };

    java = {
      enable = true;
      package = pkgs.jdk21;
    };

    clash-verge = {
      enable = true;
      serviceMode = true;
      tunMode = true;
      autoStart = true;
    };
  };
}
