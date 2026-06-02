{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
    platformio
    python313

    jetbrains.pycharm
    jetbrains.webstorm
  ];

  environment.variables = {
    PYCHARM_PYTHON_PATH = "${pkgs.python313}/bin/python3";
  };
}
