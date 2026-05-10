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
    };

    java.enable = true;
  };
}
