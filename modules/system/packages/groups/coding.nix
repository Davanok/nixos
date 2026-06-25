{ pkgs, ... }:

let
  vmoptions = ''
-javaagent:${pkgs.jetbra}/ja-netfilter.jar=jetbrains
--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
  '';
in {
  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
    platformio

    python313
    nodejs

#    (jetbrains.pycharm.override { vmopts = vmoptions; })
#    (jetbrains.webstorm.override { vmopts = vmoptions; })
  ];

#  environment.variables = {
#    PYCHARM_PYTHON_PATH = "${pkgs.python313}/bin/python3";
#  };
}
