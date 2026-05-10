{ pkgs, ... }:

{
  programs.vscodium = {
    enable = true;

    package = pkgs.vscodium;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      platformio.platformio-vscode-ide
      jnoortheen.nix-ide
      ms-vscode.cpptools
    ];
  };
}
