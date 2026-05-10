{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python313

    android-studio-full
    jdk17
    android-tools
  ];

  environment.variables = {
    JAVA_HOME = pkgs.jdk17.home;
  };
}
