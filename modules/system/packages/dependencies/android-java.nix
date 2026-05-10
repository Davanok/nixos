{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-studio-full
    jdk17
    android-tools
    platformio
    python313
  ];

  environment.variables = {
    JAVA_HOME = pkgs.jdk17.home;
  };
}
